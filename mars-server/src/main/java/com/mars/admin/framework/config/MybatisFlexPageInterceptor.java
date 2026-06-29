package com.mars.admin.framework.config;

import com.mybatisflex.core.paginate.Page;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlSource;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.scripting.defaults.DefaultParameterHandler;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * 代码领取微信公众号【程序员Mars】
 *
 * @className: MybatisFlexPageInterceptor
 * @author: Mars
 * @date: 2025/8/3 22:33
 */
@Intercepts({
        @Signature(
                type = Executor.class,
                method = "query",
                args = {
                        MappedStatement.class,
                        Object.class,
                        RowBounds.class,
                        ResultHandler.class
                }
        )
})
public class MybatisFlexPageInterceptor implements Interceptor {

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        Object[] args = invocation.getArgs();

        MappedStatement ms = (MappedStatement) args[0];
        Object paramObj = args[1];

        // 判断是否为 Page 参数
        Page<?> page = extractPage(paramObj);
        if (page == null) {
            return invocation.proceed(); // 非分页，跳过
        }

        BoundSql boundSql = ms.getBoundSql(paramObj);
        String originalSql = boundSql.getSql();

        // 1️⃣ 构造 count SQL
        String countSql = "SELECT COUNT(*) FROM (" + originalSql + ") AS total";

        Configuration configuration = ms.getConfiguration();
        Connection connection = configuration.getEnvironment().getDataSource().getConnection();
        PreparedStatement countStmt = connection.prepareStatement(countSql);
        DefaultParameterHandler handler = new DefaultParameterHandler(ms, paramObj, boundSql);
        handler.setParameters(countStmt);

        ResultSet rs = countStmt.executeQuery();
        long total = 0;
        if (rs.next()) {
            total = rs.getLong(1);
        }
        rs.close();
        countStmt.close();

        // 设置总数
        page.setTotalRow(total);
        if (total == 0) {
            page.setRecords(Collections.emptyList());
            return Collections.singletonList(page);
        }
        long offset = (page.getPageNumber() - 1) * page.getPageSize();

        // 2️⃣ 构造分页 SQL
        String pageSql = originalSql + " LIMIT " + (offset) + "," + page.getPageSize();

        BoundSql newBoundSql = new BoundSql(
                configuration,
                pageSql,
                boundSql.getParameterMappings(),
                paramObj
        );

        // 3️⃣ 创建新的 MappedStatement（原样复制）
        MappedStatement newMs = copyMappedStatement(ms, newBoundSql);

        args[0] = newMs;
        Object result = invocation.proceed();
        page.setRecords((List) result);
        return Collections.singletonList(page);
    }

    private Page<?> extractPage(Object param) {
        if (param instanceof Page) return (Page<?>) param;
        if (param instanceof Map) {
            for (Object value : ((Map<?, ?>) param).values()) {
                if (value instanceof Page) {
                    return (Page<?>) value;
                }
            }
        }
        return null;
    }

    private MappedStatement copyMappedStatement(MappedStatement ms, BoundSql newBoundSql) {
        return new MappedStatement.Builder(ms.getConfiguration(), ms.getId(), new BoundSqlSqlSource(newBoundSql), ms.getSqlCommandType())
                .parameterMap(ms.getParameterMap())
                .resultMaps(ms.getResultMaps())
                .resultSetType(ms.getResultSetType())
                .statementType(ms.getStatementType())
                .fetchSize(ms.getFetchSize())
                .timeout(ms.getTimeout())
                .cache(ms.getCache())
                .build();
    }

    static class BoundSqlSqlSource implements SqlSource {
        private final BoundSql boundSql;

        public BoundSqlSqlSource(BoundSql boundSql) {
            this.boundSql = boundSql;
        }

        @Override
        public BoundSql getBoundSql(Object parameterObject) {
            return boundSql;
        }
    }
}
