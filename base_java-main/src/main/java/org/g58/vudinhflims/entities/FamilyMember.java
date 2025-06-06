package org.g58.vudinhflims.entities;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Entity đại diện cho thành viên trong gia đình
 */
@Entity
@Table(name = "family_members")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@ToString(callSuper = true, exclude = {"contact", "account", "memberEvents", "memberNotifications", "merits", "payerMerits", "husbandMarriages", "wifeMarriages"})
@EqualsAndHashCode(callSuper = true, exclude = {"contact", "account", "memberEvents", "memberNotifications", "merits", "payerMerits", "husbandMarriages", "wifeMarriages"})
public class FamilyMember extends BaseEntityWithAudit {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_id")
    private Long memberID;

    @Column(name = "father_id")
    private Integer fatherID;

    @Column(name = "mother_id")
    private Integer motherID;

    @Column(name = "full_name")
    private String fullName;

    @Column(name = "gender")
    private String gender;

    @Column(name = "generation")
    private String generation;

    @Column(name = "role_family")
    private String roleFamily;

    @Column(name = "birth_date")
    private LocalDate birthDate;

    @Column(name = "date_of_death")
    private LocalDate dateOfDeath;

    @Column(name = "life_status")
    private String lifeStatus;

    @Column(name = "grave_site")
    private String graveSite;

    @Column(name = "address", columnDefinition = "TEXT")
    private String address;

    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Contact> contacts;

    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "account_id", referencedColumnName = "account_id")
    private Account account;

    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<MemberEvent> memberEvents;

    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<MemberNotification> memberNotifications;

    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Merit> merits;

    @OneToMany(mappedBy = "payerMember", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Merit> payerMerits;

    @OneToMany(mappedBy = "husband", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Marriage> husbandMarriages;

    @OneToMany(mappedBy = "wife", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Marriage> wifeMarriages;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}