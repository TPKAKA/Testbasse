package org.g58.vudinhflims.entities;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;

/**
 * Entity đại diện cho mối quan hệ giữa Member và Notification
 * Sử dụng composite key (memberID, notificationID)
 */
@Entity
@Table(name = "member_notification")
@IdClass(MemberNotificationId.class)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@ToString(callSuper = true, exclude = {"member", "notification"})
@EqualsAndHashCode(callSuper = true, exclude = {"member", "notification"})
public class MemberNotification extends BaseEntityWithAudit {
    
    @Id
    @Column(name = "member_id", nullable = false)
    private Long memberID;

    @Id
    @Column(name = "notification_id", nullable = false)
    private Long notificationID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "member_id",
        referencedColumnName = "member_id",
        insertable = false,
        updatable = false
    )
    private FamilyMember member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "notification_id",
        referencedColumnName = "notification_id",
        insertable = false,
        updatable = false
    )
    private Notification notification;
}