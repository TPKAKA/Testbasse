package org.g58.vudinhflims.entities;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "merit_spending")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@ToString(callSuper = true, exclude = {"merit", "meritEvent"})
@EqualsAndHashCode(callSuper = true, exclude = {"merit", "meritEvent"})
public class MeritSpending extends BaseEntityWithAudit {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "merit_spending_id")
    private Long meritSpendingID;

    @Column(name = "amount", precision = 10, scale = 2)
    private BigDecimal amount;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "spending_date")
    private LocalDate spendingDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "merit_id", referencedColumnName = "merit_id")
    private Merit merit;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "merit_event_id", referencedColumnName = "merit_event_id")
    private MeritEvent meritEvent;
} 