package mingjie.rssfusion.pojo;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

public class Comment {
    // Getters and Setters
    @Setter
    @Getter
    private Long id;
    private Long articleId;
    private Long userId;
    private String content;
    private Long parentCommentId;
    private LocalDateTime createdAt;
}
