package mingjie.rssfusion.pojo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Article {
    private Long id;
    private String title;
    private String content;
    private Long authorId;
    private Integer categoryId;
    private String coverImage;
    private String status;
    private LocalDateTime publishTime;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private Long articleId;
    private Boolean allowComments;
    private Boolean allowSharing;

    private Long viewCount;
    private Long likeCount;
    private Long commentCount;
    private Long shareCount;
}
