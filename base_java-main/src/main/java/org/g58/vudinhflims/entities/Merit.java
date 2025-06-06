package org.g58.vudinhflims.entities;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "merits")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@ToString(exclude = {"meritEvent", "payerMember", "member", "meritType", "meritSpendings", "meritBankingInfos"})
@EqualsAndHashCode(exclude = {"meritEvent", "payerMember", "member", "meritType", "meritSpendings", "meritBankingInfos"})
public class Merit {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "merit_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "merit_event_id", referencedColumnName = "merit_event_id")
    private MeritEvent meritEvent;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "payer_member_id", referencedColumnName = "member_id")
    private FamilyMember payerMember;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id", referencedColumnName = "member_id")
    private FamilyMember member;

    @Column(name = "qr_code_url")
    private String qrCodeURL;

    @Column(name = "amount", precision = 10, scale = 2)
    private BigDecimal amount;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "merit_date")
    private LocalDate meritDate;

    @Column(name = "payment_status")
    private String paymentStatus;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "merit_type_id", referencedColumnName = "merit_type_id")
    private MeritType meritType;

    @OneToMany(mappedBy = "merit", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<MeritSpending> meritSpendings;

    @OneToMany(mappedBy = "merit", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<MeritBankingInfo> meritBankingInfos;

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