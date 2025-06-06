package org.g58.vudinhflims.entities;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;

@Entity
@Table(name = "merit_type")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
public class MeritType extends BaseEntityWithAudit {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "merit_type_id")
    private Long meritTypeID;

    @Column(name = "merit_type_name")
    private String meritTypeName;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;
} 