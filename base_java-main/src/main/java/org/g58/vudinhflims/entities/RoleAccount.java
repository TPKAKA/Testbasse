package org.g58.vudinhflims.entities;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;

/**
 * Entity đại diện cho mối quan hệ giữa Account và Role
 * Sử dụng composite key (accountID, roleID)
 */
@Entity
@Table(name = "role_account")
@IdClass(RoleAccountId.class)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@ToString(callSuper = true, exclude = {"account", "role"})
@EqualsAndHashCode(callSuper = true, exclude = {"account", "role"})
public class RoleAccount extends BaseEntityWithAudit {
    
    @Id
    @Column(name = "account_id", nullable = false)
    private Long accountID;

    @Id
    @Column(name = "role_id", nullable = false)
    private Long roleID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "account_id",
        referencedColumnName = "account_id",
        insertable = false,
        updatable = false
    )
    private Account account;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "role_id",
        referencedColumnName = "role_id",
        insertable = false,
        updatable = false
    )
    private Role role;
}