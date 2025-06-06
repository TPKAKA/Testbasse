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
public class RoleAccountId implements Serializable {
    @Column(name = "account_id")
    private Long accountID;

    @Column(name = "role_id")
    private Long roleID;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RoleAccountId that = (RoleAccountId) o;
        return Objects.equals(accountID, that.accountID) &&
               Objects.equals(roleID, that.roleID);
    }

    @Override
    public int hashCode() {
        return Objects.hash(accountID, roleID);
    }
} 