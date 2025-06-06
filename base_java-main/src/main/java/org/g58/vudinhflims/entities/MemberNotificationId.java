package org.g58.vudinhflims.entities;

import jakarta.persistence.Embeddable;
import jakarta.persistence.Column;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberNotificationId implements Serializable {
    @Column(name = "member_id")
    private Long memberID;

    @Column(name = "notification_id")
    private Long notificationID;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MemberNotificationId that = (MemberNotificationId) o;
        return Objects.equals(memberID, that.memberID) &&
               Objects.equals(notificationID, that.notificationID);
    }

    @Override
    public int hashCode() {
        return Objects.hash(memberID, notificationID);
    }
} 