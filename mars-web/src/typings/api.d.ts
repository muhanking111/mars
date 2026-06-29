/**
 * Namespace Api
 *
 * All backend api type
 */
declare namespace Api {
  namespace Common {
    /** common params of paginating */
    interface PaginatingCommonParams {
      /** current page number */
      current: number;
      /** page size */
      size: number;
      /** total count */
      total: number;
    }

    /** common params of paginating query list data */
    interface PaginatingQueryRecord<T = any> extends PaginatingCommonParams {
      records: T[];
    }

    /** common search params of table */
    type CommonSearchParams = Pick<Common.PaginatingCommonParams, 'current' | 'size'>;

    /**
     * enable status
     *
     * - 0: disabled
     * - 1: enabled
     */
    type EnableStatus = 0 | 1;

    /** common record */
    type CommonRecord<T = any> = {
      /** record id */
      id: number;
      /** record creator */
      createBy: string;
      /** record create time */
      createTime: string;
      /** record updater */
      updateBy: string;
      /** record update time */
      updateTime: string;
      /** record status */
      status: EnableStatus;
    } & T;
  }

  /**
   * Namespace Auth
   *
   * Backend api module: "auth"
   */
  namespace Auth {
    interface LoginToken {
      token: string;
      refreshToken: string;
    }

    interface UserInfo {
      userId: string;
      username: string;
      nickname: string;
      avatar: string;
      roles: string[];
      permissions: string[];
      routes?: Route.MenuRoute[];
    }

    interface CaptchaData {
      uuid: string;
      img: string;
    }
  }

  /**
   * Namespace Route
   *
   * Backend api module: "route"
   */
  namespace Route {
    type ElegantConstRoute = import('@elegant-router/types').ElegantConstRoute;

    interface MenuRoute extends ElegantConstRoute {
      id: string;
    }

    interface UserRoute {
      routes: MenuRoute[];
      home: import('@elegant-router/types').LastLevelRouteKey;
    }
  }

  /**
   * namespace SystemManage
   *
   * backend api module: "systemManage"
   */
  namespace SystemManage {
    /** role */
    type Role = Common.CommonRecord<{
      /** role name */
      roleName: string;
      /** role code */
      roleCode: string;
      /** role key */
      roleKey: string;
      /** role description */
      description: string;
      /** role sort */
      roleSort: number;
      /** data scope */
      dataScope: string;
      /** menu check strictly */
      menuCheckStrictly: boolean;
      /** dept check strictly */
      deptCheckStrictly: boolean;
    }>;

    /** role search params */
    type RoleSearchParams = Partial<
      Pick<Api.SystemManage.Role, 'roleName' | 'roleCode' | 'roleKey' | 'status'> & Common.CommonSearchParams
    >;

    /** role list */
    type RoleList = Common.PaginatingQueryRecord<Role>;

    /** all role */
    type AllRole = Pick<Role, 'id' | 'roleName' | 'roleCode'>;

    /**
     * user gender
     *
     * - 0: male
     * - 1: female
     * - 2: unknown
     */
    type UserGender = 0 | 1 | 2;

    /** user */
    type User = Common.CommonRecord<{
      /** user name */
      username: string;
      /** nick name */
      nickname: string;
      /** user gender */
      gender: UserGender;
      /** user phone */
      phone: string;
      /** user email */
      email: string;
      /** avatar */
      avatar: string;
      /** dept ids */
      deptIds: number[];
      /** dept name */
      deptName: string;
      /** user role ids */
      roleIds: number[];
      /** user post ids */
      postIds: number[];
      /** remark */
      remark: string;
    }>;

    /** user search params */
    type UserSearchParams = Partial<
      Pick<Api.SystemManage.User, 'username' | 'gender' | 'nickname' | 'phone' | 'email' | 'status'> &
        Common.CommonSearchParams
    >;

    /** user list */
    type UserList = Common.PaginatingQueryRecord<User>;

    /**
     * menu type
     *
     * - "M": directory
     * - "C": menu
     * - "F": button
     */
    type MenuType = 'M' | 'C' | 'F';

    type MenuButton = {
      /**
       * button code
       *
       * it can be used to control the button permission
       */
      code: string;
      /** button description */
      desc: string;
    };

    /**
     * icon type
     *
     * - "1": iconify icon
     * - "2": local icon
     */
    type IconType = '1' | '2';

    type MenuPropsOfRoute = Pick<
      import('vue-router').RouteMeta,
      | 'i18nKey'
      | 'keepAlive'
      | 'constant'
      | 'order'
      | 'href'
      | 'hideInMenu'
      | 'activeMenu'
      | 'multiTab'
      | 'fixedIndexInTab'
      | 'query'
    >;

    type Menu = Common.CommonRecord<{
      /** parent menu id */
      parentId: number;
      /** menu type */
      menuType: MenuType;
      /** menu name */
      menuName: string;
      /** menu code */
      menuCode: string;
      /** route name */
      routeName: string;
      /** route path */
      routePath: string;
      /** component */
      component: string;
      /** permission */
      perms: string;
      /** visible */
      visible: string;
      /** is frame */
      isFrame: string;
      /** is cache */
      isCache: string;
      /** menu sort */
      menuSort: number;
      /** iconify icon name or local icon name */
      icon: string;
      /** icon type */
      iconType: IconType;
      /** buttons */
      buttons?: MenuButton[] | null;
      /** children menu */
      children?: Menu[];
    }> &
      MenuPropsOfRoute;

    /** menu list */
    type MenuList = Common.PaginatingQueryRecord<Menu>;

    type MenuTree = {
      id: number;
      label: string;
      pId: number;
      children?: MenuTree[];
    };

    /** dept */
    type Dept = Common.CommonRecord<{
      /** parent dept id */
      parentId: number;
      /** dept name */
      deptName: string;
      /** dept code */
      deptCode: string;
      /** order num */
      orderNum: number;
      /** leader */
      leader: string;
      /** phone */
      phone: string;
      /** email */
      email: string;
      /** children dept */
      children?: Dept[];
    }>;

    /** dept tree */
    type DeptTree = {
      id: number;
      label: string;
      pId: number;
      children?: DeptTree[];
    };

    /** post */
    type Post = Common.CommonRecord<{
      /** post name */
      postName: string;
      /** post code */
      postCode: string;
      /** post sort */
      postSort: number;
      /** remark */
      remark: string;
    }>;

    /** post search params */
    type PostSearchParams = Partial<
      Pick<Api.SystemManage.Post, 'postName' | 'postCode' | 'status'> & Common.CommonSearchParams
    >;

    /** post list */
    type PostList = Common.PaginatingQueryRecord<Post>;

    /** dict type */
    type DictType = Common.CommonRecord<{
      /** dict name */
      dictName: string;
      /** dict type */
      dictType: string;
      /** remark */
      remark: string;
    }>;

    /** dict type search params */
    type DictTypeSearchParams = Partial<
      Pick<Api.SystemManage.DictType, 'dictName' | 'dictType' | 'status'> & Common.CommonSearchParams
    >;

    /** dict type list */
    type DictTypeList = Common.PaginatingQueryRecord<DictType>;

    /** dict data */
    type DictData = Common.CommonRecord<{
      /** dict sort */
      dictSort: number;
      /** dict label */
      dictLabel: string;
      /** dict value */
      dictValue: string;
      /** dict type */
      dictType: string;
      /** css class */
      cssClass: string;
      /** list class */
      listClass: string;
      /** is default */
      isDefault: string;
      /** remark */
      remark: string;
    }>;

    /** dict data search params */
    type DictDataSearchParams = Partial<
      Pick<Api.SystemManage.DictData, 'dictLabel' | 'dictValue' | 'dictType' | 'status'> & Common.CommonSearchParams
    >;

    /** dict data list */
    type DictDataList = Common.PaginatingQueryRecord<DictData>;

    /** config */
    type Config = Common.CommonRecord<{
      /** config name */
      configName: string;
      /** config key */
      configKey: string;
      /** config value */
      configValue: string;
      /** config type */
      configType: string;
      /** remark */
      remark: string;
    }>;

    /** config search params */
    type ConfigSearchParams = Partial<
      Pick<Api.SystemManage.Config, 'configName' | 'configKey' | 'configType' | 'status'> & Common.CommonSearchParams
    >;

    /** config list */
    type ConfigList = Common.PaginatingQueryRecord<Config>;

    /** operation log */
    type OperLog = Common.CommonRecord<{
      /** title */
      title: string;
      /** business type */
      businessType: number;
      /** method */
      method: string;
      /** request method */
      requestMethod: string;
      /** operator type */
      operatorType: number;
      /** oper name */
      operName: string;
      /** dept name */
      deptName: string;
      /** oper url */
      operUrl: string;
      /** oper ip */
      operIp: string;
      /** oper location */
      operLocation: string;
      /** oper param */
      operParam: string;
      /** json result */
      jsonResult: string;
      /** error msg */
      errorMsg: string;
      /** oper time */
      operTime: string;
      /** cost time */
      costTime: number;
    }>;

    /** login info */
    type LoginInfo = Common.CommonRecord<{
      /** user name */
      username: string;
      /** ipaddr */
      ipaddr: string;
      /** login location */
      loginLocation: string;
      /** browser */
      browser: string;
      /** os */
      os: string;
      /** status */
      status: Common.EnableStatus;
      /** msg */
      msg: string;
      /** login time */
      loginTime: string;
    }>;

    /** 系统监控信息 */
    type MonitorInfo = {
      server: ServerInfo;
      cpu: CpuInfo;
      memory: MemoryInfo;
      jvm: JvmInfo;
      disk: DiskInfo[];
      network: NetworkInfo;
      thread: ThreadInfo;
      systemLoad: SystemLoadInfo;
      timestamp: number;
    };

    /** 服务器信息 */
    type ServerInfo = {
      computerName: string;
      computerIp: string;
      osName: string;
      osArch: string;
      osVersion: string;
      uptime: string;
      timezone: string;
      javaVersion: string;
      processId: string;
      availableProcessors: number;
    };

    /** CPU信息 */
    type CpuInfo = {
      cpuNum: number;
      physicalCores: number;
      total: number;
      sys: number;
      used: number;
      wait: number;
      free: number;
      irq: number;
      softirq: number;
      cpuModel: string;
      architecture: string;
      frequency: number;
      cacheSize?: number;
      usagePercent: number;
    };

    /** 内存信息 */
    type MemoryInfo = {
      total: number;
      used: number;
      free: number;
      available: number;
      usage: number;
      buffers?: number;
      cached?: number;
      swapTotal: number;
      swapUsed: number;
      swapFree: number;
      swapUsage: number;
      totalFormatted: string;
      usedFormatted: string;
      availableFormatted: string;
    };

    /** JVM信息 */
    type JvmInfo = {
      total: number;
      used: number;
      free: number;
      usage: number;
      name: string;
      version: string;
      home: string;
      startTime: string;
      runTime: string;
      nonHeapTotal: number;
      nonHeapUsed: number;
      nonHeapUsage: number;
      metaspaceTotal?: number;
      metaspaceUsed?: number;
      metaspaceUsage?: number;
      compressedClassSpaceTotal?: number;
      compressedClassSpaceUsed?: number;
      jvmArgs: string[];
      classLoader: ClassLoaderInfo;
      gcInfo: GcInfo[];
      heapFormatted: string;
      nonHeapFormatted: string;
    };

    /** 磁盘信息 */
    type DiskInfo = {
      dirName: string;
      sysTypeName: string;
      typeName: string;
      total: string;
      free: string;
      used: string;
      usage: number;
    };

    /** 网络信息 */
    type NetworkInfo = {
      interfaces: NetworkInterface[];
      totalBytesSent: number;
      totalBytesReceived: number;
      totalPacketsSent: number;
      totalPacketsReceived: number;
      sendRate: number;
      receiveRate: number;
    };

    /** 网络接口信息 */
    type NetworkInterface = {
      name: string;
      displayName: string;
      macAddress: string;
      ipAddresses: string[];
      type?: string;
      status?: string;
      speed: number;
      enabled: boolean;
      bytesSent: number;
      bytesReceived: number;
      packetsSent: number;
      packetsReceived: number;
      sendErrors: number;
      receiveErrors: number;
    };

    /** 线程信息 */
    type ThreadInfo = {
      liveThreads: number;
      daemonThreads: number;
      peakThreads: number;
      totalStartedThreads: number;
      deadlockedThreads: number;
      newThreads: number;
      runnableThreads: number;
      blockedThreads: number;
      waitingThreads: number;
      timedWaitingThreads: number;
      terminatedThreads: number;
    };

    /** 系统负载信息 */
    type SystemLoadInfo = {
      load1: number;
      load5: number;
      load15: number;
      bootTime: number;
      uptime: number;
      processCount: number;
      runningProcesses: number;
      sleepingProcesses?: number;
      stoppedProcesses?: number;
      zombieProcesses?: number;
      loadLevel: string;
      loadPercent: number;
    };

    /** 类加载器信息 */
    type ClassLoaderInfo = {
      loadedClassCount: number;
      totalLoadedClassCount: number;
      unloadedClassCount: number;
      verbose: boolean;
    };

    /** 垃圾回收信息 */
    type GcInfo = {
      name: string;
      type: string;
      collectionCount: number;
      collectionTime: number;
      averageCollectionTime: number;
      lastCollectionTime?: string;
      frequency?: number;
    };
  }

  /**
   * namespace CacheManage
   *
   * backend api module: "cacheManage"
   */
  namespace CacheManage {
    /** Redis信息 */
    type RedisInfo = {
      redis_version: string;
      redis_mode: string;
      tcp_port: string;
      uptime_in_seconds: string;
      uptime_in_days: string;
      connected_clients: string;
      used_memory_human: string;
      used_memory_peak_human: string;
      maxmemory_human: string;
      mem_fragmentation_ratio: string;
      keyspace_hits: string;
      keyspace_misses: string;
      total_commands_processed: string;
      instantaneous_ops_per_sec: string;
      hit_rate: string;
    };

    /** JVM信息 */
    type JvmInfo = {
      heap_used: string;
      heap_committed: string;
      heap_max: string;
      non_heap_used: string;
      non_heap_committed: string;
      heap_usage: string;
    };

    /** 缓存统计信息 */
    type CacheInfo = {
      total_keys: number;
      cache_spaces: Record<string, number>;
    };

    /** 服务器信息 */
    type ServerInfo = {
      server_time: string;
      java_version: string;
      os_name: string;
      os_arch: string;
    };

    /** 缓存监控信息 */
    type MonitorInfo = {
      redis: RedisInfo;
      jvm: JvmInfo;
      cache: CacheInfo;
      server: ServerInfo;
    };

    /** 缓存项 */
    type CacheItem = {
      key: string;
      ttl: number;
      ttl_text: string;
      type: string;
      size: string;
      cache_space: string;
      cache_space_name: string;
    };

    /** 缓存详情 */
    type CacheDetail = CacheItem & {
      value: any;
    };

    /** 缓存列表响应 */
    type CacheListResponse = {
      records: CacheItem[];
      total: number;
      current: number;
      size: number;
      pages: number;
    };

    /** 缓存空间统计 */
    type CacheSpaceStat = {
      space: string;
      name: string;
      count: number;
      color: string;
    };

    /** 缓存统计 */
    type CacheStats = {
      spaces: CacheSpaceStat[];
      total: number;
    };
  }

  /** 文件管理模块 */
  namespace FileManage {
    /** 文件信息 */
    interface FileInfo {
      id: number;
      fileName: string;
      originalName: string;
      fileSuffix: string;
      url: string;
      size: number;
      configKey: string;
      filePath: string;
      contentType: string;
      uploadId?: string;
      uploadStatus: number;
      remark?: string;
      createTime: string;
      updateTime: string;
      createBy?: number;
      updateBy?: number;
    }

    /** 文件上传结果 */
    interface FileUploadResult {
      id: number;
      fileName: string;
      originalName: string;
      fileSuffix: string;
      url: string;
      size: number;
      configKey: string;
      filePath: string;
      contentType: string;
      uploadStatus: number;
    }

    /** 文件搜索参数 */
    interface FileSearchParams {
      current: number;
      size: number;
      fileName?: string;
      configKey?: string;
      contentType?: string;
    }

    /** 文件列表 */
    interface FileList {
      current: number;
      size: number;
      total: number;
      records: FileInfo[];
    }

    /** OSS配置信息 */
    interface OssConfig {
      id: number;
      configKey: string;
      accessKey?: string;
      secretKey?: string;
      bucketName?: string;
      prefix?: string;
      endpoint?: string;
      domain?: string;
      isHttps?: number;
      region?: string;
      accessPolicy?: number;
      status: number;
      ext1?: string;
      remark?: string;
      createTime: string;
      updateTime: string;
      createBy?: number;
      updateBy?: number;
    }

    /** OSS配置搜索参数 */
    interface OssConfigSearchParams {
      current: number;
      size: number;
      configKey?: string;
      status?: number;
    }

    /** OSS配置列表 */
    interface OssConfigList {
      current: number;
      size: number;
      total: number;
      records: OssConfig[];
    }

    /** 文件预览信息 */
    interface FilePreviewInfo {
      /** 预览类型：1-直接预览(图片等)，2-Office预览，3-PDF预览，4-视频预览，5-音频预览，0-不支持预览 */
      previewType: number;
      /** 预览URL */
      previewUrl: string;
      /** 文件内容类型 */
      contentType: string;
      /** 文件原始名称 */
      originalName: string;
      /** 文件大小 */
      size: number;
      /** 是否需要转换 */
      needConvert: boolean;
      /** 预览参数 */
      previewParams?: string;
    }
  }

  /** 日志管理 */
  namespace LogManage {
    /** 操作日志 */
    interface OperLog {
      /** 日志主键 */
      id?: number;
      /** 模块标题 */
      title?: string;
      /** 业务类型：0-其它，1-新增，2-修改，3-删除 */
      businessType?: number;
      /** 方法名称 */
      method?: string;
      /** 请求方式 */
      requestMethod?: string;
      /** 操作类别：0-其它，1-后台用户，2-手机端用户 */
      operatorType?: number;
      /** 操作人员 */
      operName?: string;
      /** 部门名称 */
      deptName?: string;
      /** 请求URL */
      operUrl?: string;
      /** 主机地址 */
      operIp?: string;
      /** 操作地点 */
      operLocation?: string;
      /** 请求参数 */
      operParam?: string;
      /** 返回参数 */
      jsonResult?: string;
      /** 操作状态：0-正常，1-异常 */
      status?: number;
      /** 错误消息 */
      errorMsg?: string;
      /** 操作时间 */
      operTime?: number;
      /** 消耗时间 */
      costTime?: number;
    }

    /** 操作日志搜索参数 */
    interface OperLogSearchParams {
      /** 当前页码 */
      current?: number;
      /** 页面大小 */
      size?: number;
      /** 模块标题 */
      title?: string;
      /** 操作人员 */
      operName?: string;
      /** 业务类型 */
      businessType?: number;
      /** 状态 */
      status?: number;
      /** 操作IP */
      operIp?: string;
    }

    /** 操作日志列表 */
    interface OperLogList {
      current: number;
      size: number;
      total: number;
      records: OperLog[];
    }

    /** 登录日志 */
    interface LoginLog {
      /** 访问ID */
      id?: number;
      /** 用户账号 */
      userName?: string;
      /** 登录IP地址 */
      ipaddr?: string;
      /** 登录地点 */
      loginLocation?: string;
      /** 浏览器类型 */
      browser?: string;
      /** 操作系统 */
      os?: string;
      /** 登录状态：0-成功，1-失败 */
      status?: string;
      /** 提示消息 */
      msg?: string;
      /** 访问时间 */
      loginTime?: string;
    }

    /** 登录日志搜索参数 */
    interface LoginLogSearchParams {
      /** 当前页码 */
      current?: number;
      /** 页面大小 */
      size?: number;
      /** 用户账号 */
      userName?: string;
      /** 登录IP地址 */
      ipaddr?: string;
      /** 登录状态 */
      status?: string;
      /** 登录地点 */
      loginLocation?: string;
    }

    /** 登录日志列表 */
    interface LoginLogList {
      current: number;
      size: number;
      total: number;
      records: LoginLog[];
    }

    /** 接口日志 */
    interface ApiLog {
      id?: number;
      traceId?: string;
      requestMethod?: string;
      requestUrl?: string;
      classMethod?: string;
      operName?: string;
      operIp?: string;
      operLocation?: string;
      browser?: string;
      os?: string;
      requestParams?: string;
      responseBody?: string;
      responseCode?: number;
      /** 0-正常 1-异常 */
      status?: number;
      errorMsg?: string;
      costTime?: number;
      createTime?: string;
    }

    /** 接口日志搜索参数 */
    interface ApiLogSearchParams {
      current?: number;
      size?: number;
      operName?: string;
      requestUrl?: string;
      requestMethod?: string;
      status?: number | null;
      operIp?: string;
    }

    /** 接口日志列表 */
    interface ApiLogList {
      current: number;
      size: number;
      total: number;
      records: ApiLog[];
    }
  }

  /** 轮播图管理模块 */
  namespace BannerManage {
    /** 轮播图 */
    interface Banner {
      /** 主键ID */
      id?: number;
      /** 关联轮播图详情ID */
      toDetailId?: number;
      /** 轮播图类型 */
      type?: string;
      /** 轮播图标题 */
      title?: string;
      /** 图片URL */
      imageUrl?: string;
      /** 跳转链接 */
      link?: string;
      /** 展示位置标识 */
      position?: string;
      /** 排序值 */
      sort?: number;
      /** 状态 */
      status?: number;
      /** 开始时间 */
      startTime?: string;
      /** 结束时间 */
      endTime?: string;
      /** 备注 */
      remark?: string;
      /** 创建时间 */
      createTime?: string;
      /** 更新时间 */
      updateTime?: string;
    }

    /** 轮播图搜索参数 */
    interface BannerSearchParams {
      /** 当前页码 */
      current?: number;
      /** 页面大小 */
      size?: number;
      /** 轮播图标题 */
      title?: string;
      /** 轮播图类型 */
      type?: string;
      /** 展示位置 */
      position?: string;
      /** 状态 */
      status?: number;
    }

    /** 轮播图列表 */
    interface BannerList {
      current: number;
      size: number;
      total: number;
      records: Banner[];
    }
  }

  /** 活动分类管理模块 */
  namespace ActivityCategoryManage {
    /** 活动分类 */
    interface ActivityCategory {
      /** 分类ID */
      id?: number;
      /** 父分类ID，0为根分类 */
      parentId?: number;
      /** 分类名称 */
      name?: string;
      /** 分类图标 */
      icon?: string;
      /** 分类封面图 */
      coverImage?: string;
      /** 分类描述 */
      description?: string;
      /** 排序 */
      sortOrder?: number;
      /** 是否热门：0-否，1-是 */
      isHot?: number;
      /** 状态：0-禁用，1-启用 */
      status?: number;
      /** 创建时间 */
      createTime?: string;
      /** 更新时间 */
      updateTime?: string;
    }

    /** 活动分类搜索参数 */
    interface ActivityCategorySearchParams {
      current: number;
      size: number;
      /** 分类名称 */
      name?: string;
      /** 状态 */
      status?: number;
      /** 是否热门 */
      isHot?: number;
    }

    /** 活动分类列表 */
    interface ActivityCategoryList {
      current: number;
      size: number;
      total: number;
      records: ActivityCategory[];
    }
  }

  /** 活动管理模块 */
  namespace ActivityManage {
    /** 活动 */
    interface Activity {
      /** 活动ID */
      id?: number;
      /** 分类ID */
      categoryId?: number;
      /** 发布者用户ID */
      userId?: number;
      /** 活动标题 */
      title?: string;
      /** 活动副标题 */
      subtitle?: string;
      /** 活动描述 */
      description?: string;
      /** 封面图片 */
      coverImage?: string;
      /** 活动图片集合 */
      images?: string;
      /** 活动视频 */
      videoUrl?: string;
      /** 活动地点 */
      location?: string;
      /** 详细地址 */
      address?: string;
      /** 纬度 */
      latitude?: number;
      /** 经度 */
      longitude?: number;
      /** 地区ID */
      regionId?: number;
      /** 活动礼品ID */
      giftId?: number;
      /** 开始时间 */
      startTime?: string;
      /** 结束时间 */
      endTime?: string;
      /** 报名开始时间 */
      registrationStartTime?: string;
      /** 报名结束时间 */
      registrationEndTime?: string;
      /** 最大参与人数 */
      maxParticipants?: number;
      /** 最小参与人数 */
      minParticipants?: number;
      /** 当前参与人数 */
      currentParticipants?: number;
      /** 活动价格 */
      price?: number;
      /** 原价 */
      originalPrice?: number;
      /** 是否免费：0-收费，1-免费 */
      isFree?: number;
      /** 是否需要审核：0-不需要，1-需要 */
      needApproval?: number;
      /** 活动类型：1-线下活动，2-线上活动，3-混合活动 */
      activityType?: number;
      /** 难度等级：1-简单，2-中等，3-困难，4-极限 */
      difficultyLevel?: number;
      /** 最小年龄限制 */
      ageLimitMin?: number;
      /** 最大年龄限制 */
      ageLimitMax?: number;
      /** 性别限制：0-不限，1-仅男性，2-仅女性 */
      genderLimit?: number;
      /** 联系人 */
      contactPerson?: string;
      /** 联系电话 */
      contactPhone?: string;
      /** 微信号 */
      contactWechat?: string;
      /** 参与要求 */
      requirements?: string;
      /** 费用包含 */
      includes?: string;
      /** 费用不含 */
      excludes?: string;
      /** 注意事项 */
      notes?: string;
      /** 活动标签 */
      tags?: string;
      /** 是否置顶：0-否，1-是 */
      isTop?: number;
      /** 是否热门：0-否，1-是 */
      isHot?: number;
      /** 是否推荐：0-否，1-是 */
      isRecommend?: number;
      /** 状态：0-草稿，1-已发布，2-已取消，3-已结束，4-审核中，5-审核拒绝 */
      status?: number;
      /** 审核状态：0-待审核，1-审核通过，2-审核拒绝 */
      auditStatus?: number;
      /** 审核原因 */
      auditReason?: string;
      /** 审核时间 */
      auditTime?: string;
      /** 审核人ID */
      auditUserId?: number;
      /** 创建时间 */
      createTime?: string;
      /** 更新时间 */
      updateTime?: string;
    }

    /** 活动搜索参数 */
    interface ActivitySearchParams {
      current: number;
      size: number;
      /** 活动标题 */
      title?: string;
      /** 分类ID */
      categoryId?: number;
      /** 发布者用户ID */
      userId?: number;
      /** 状态 */
      status?: number;
      /** 审核状态 */
      auditStatus?: number;
      /** 活动类型 */
      activityType?: number;
      /** 地区ID */
      regionId?: number;
      /** 是否置顶 */
      isTop?: number;
      /** 是否热门 */
      isHot?: number;
      /** 是否推荐 */
      isRecommend?: number;
    }

    /** 活动列表 */
    interface ActivityList {
      current: number;
      size: number;
      total: number;
      records: Activity[];
    }
  }

  /** 话题管理模块 */
  namespace TopicManage {
    /** 话题 */
    interface Topic {
      /** 话题ID */
      id?: number;
      /** 话题名称 */
      name?: string;
      /** 话题描述 */
      description?: string;
      /** 话题封面图 */
      coverImage?: string;
      /** 话题图标 */
      icon?: string;
      /** 话题颜色 */
      color?: string;
      /** 话题分类 */
      category?: string;
      /** 帖子数量 */
      postsCount?: number;
      /** 关注数量 */
      followersCount?: number;
      /** 是否热门：0-否，1-是 */
      isHot?: number;
      /** 是否官方话题：0-否，1-是 */
      isOfficial?: number;
      /** 排序 */
      sortOrder?: number;
      /** 状态：0-禁用，1-启用 */
      status?: number;
      /** 创建时间 */
      createTime?: string;
      /** 更新时间 */
      updateTime?: string;
    }

    /** 话题搜索参数 */
    interface TopicSearchParams {
      /** 页码 */
      pageNumber?: number;
      /** 每页数量 */
      pageSize?: number;
      /** 话题名称 */
      name?: string;
      /** 话题分类 */
      category?: string;
      /** 是否热门 */
      isHot?: number;
      /** 是否官方 */
      isOfficial?: number;
      /** 状态 */
      status?: number;
    }

    /** 话题列表 */
    interface TopicList {
      current: number;
      size: number;
      total: number;
      records: Topic[];
    }
  }

  /** 动态管理模块 */
  namespace PostManage {
    /** 帖子 */
    interface Post {
      /** 帖子ID */
      id?: number;
      /** 发布用户ID */
      userId?: number;
      /** 用户昵称 */
      userNickname?: string;
      /** 用户头像 */
      userAvatar?: string;
      /** 帖子标题 */
      title?: string;
      /** 帖子内容 */
      content?: string;
      /** 图片集合 */
      images?: string;
      /** 图片列表 */
      imagesList?: string[];
      /** 视频URL */
      videoUrl?: string;
      /** 视频封面 */
      videoCover?: string;
      /** 帖子类型：1-图文，2-视频 */
      postType?: number;
      /** 地理位置 */
      location?: string;
      /** 经度 */
      longitude?: number;
      /** 纬度 */
      latitude?: number;
      /** 点赞数 */
      likesCount?: number;
      /** 评论数 */
      commentsCount?: number;
      /** 分享数 */
      sharesCount?: number;
      /** 浏览数 */
      viewsCount?: number;
      /** 收藏数 */
      collectsCount?: number;
      /** 是否置顶：0-否，1-是 */
      isTop?: number;
      /** 是否热门：0-否，1-是 */
      isHot?: number;
      /** 是否推荐：0-否，1-是 */
      isRecommend?: number;
      /** 状态：0-禁用，1-启用 */
      status?: number;
      /** 审核状态：0-待审核，1-审核通过，2-审核拒绝 */
      auditStatus?: number;
      /** 审核备注 */
      auditRemark?: string;
      /** 话题ID列表 */
      topicIds?: number[];
      /** 创建时间 */
      createTime?: string;
      /** 更新时间 */
      updateTime?: string;
    }

    /** 帖子搜索参数 */
    interface PostSearchParams {
      /** 页码 */
      pageNumber?: number;
      /** 每页数量 */
      pageSize?: number;
      /** 用户ID */
      userId?: number;
      /** 话题ID */
      topicId?: number;
      /** 帖子类型 */
      postType?: number;
      /** 是否热门 */
      isHot?: number;
      /** 是否推荐 */
      isRecommend?: number;
      /** 状态 */
      status?: number;
      /** 审核状态 */
      auditStatus?: number;
      /** 关键词 */
      keyword?: string;
      /** 开始时间 */
      startTime?: string;
      /** 结束时间 */
      endTime?: string;
    }

    /** 帖子列表 */
    interface PostList {
      current: number;
      size: number;
      total: number;
      records: Post[];
    }
  }
}
