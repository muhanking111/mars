package com.mars.admin.common.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 图片信息DTO
 *
 * @author Mars
 * @version 1.0
 * @date 2025-01-07
 */
@Data
@Schema(description = "图片信息")
public class ImageInfoDto {
    
    @Schema(description = "文件扩展名")
    private String extname;
    
    @Schema(description = "图片详细信息")
    private ImageDetail image;
    
    @Schema(description = "图片路径")
    private String path;
    
    @Schema(description = "文件大小")
    private Long size;
    
    @Schema(description = "文件ID")
    private String fileID;
    
    @Schema(description = "图片URL")
    private String url;
    
    @Schema(description = "唯一标识")
    private Long uuid;
    
    @Schema(description = "上传状态")
    private String status;
    
    /**
     * 图片详细信息
     */
    @Data
    @Schema(description = "图片详细信息")
    public static class ImageDetail {
        @Schema(description = "图片宽度")
        private Integer width;
        
        @Schema(description = "图片高度")
        private Integer height;
        
        @Schema(description = "图片位置")
        private String location;
    }
} 