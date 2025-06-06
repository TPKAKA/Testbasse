package org.g58.vudinhflims.entities;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "merit_event")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@ToString(callSuper = true, exclude = {"merits", "meritSpendings"})
@EqualsAndHashCode(callSuper = true, exclude = {"merits", "meritSpendings"})
public class MeritEvent extends BaseEntityWithAudit {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "merit_event_id")
    private Long meritEventID;

    @Column(name = "start_date")
    private LocalDate startDate;

    @Column(name = "end_date")
    private LocalDate endDate;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @OneToMany(mappedBy = "meritEvent", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Merit> merits;

    @OneToMany(mappedBy = "meritEvent", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<MeritSpending> meritSpendings;
} 