package mingjie.rssfusion.pojo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ArticleImage {
    private Long id;
    private Long articleId;
    private String image_url;
    private String image_hash;
    private Integer position;
    private LocalDateTime createdAt;
}
