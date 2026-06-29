package com.mars.admin.modules.user.mapper;

import com.mars.admin.modules.user.entity.UserFollow;
import com.mybatisflex.core.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 用户关注关系Mapper
 *
 * @author Mars
 */
@Mapper
public interface UserFollowMapper extends BaseMapper<UserFollow> {
}