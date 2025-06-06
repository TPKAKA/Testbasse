package org.g58.vudinhflims.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDateTime;
import java.math.BigDecimal;

@Entity
@Table(name = "merit_spendings")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MeritSpending {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "merit_id", nullable = false)
    private Merit merit;

    @ManyToOne
    @JoinColumn(name = "merit_event_id", nullable = false)
    private MeritEvent meritEvent;

    @Column(name = "amount", nullable = false)
    private BigDecimal amount;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

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