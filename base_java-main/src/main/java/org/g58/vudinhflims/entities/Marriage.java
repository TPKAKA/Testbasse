package org.g58.vudinhflims.entities;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;

@Entity
@Table(name = "marriage")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@ToString(callSuper = true, exclude = {"husband", "wife"})
@EqualsAndHashCode(callSuper = true, exclude = {"husband", "wife"})
public class Marriage extends BaseEntityWithAudit {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "marriage_id")
    private Long marriageID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "husband_id", referencedColumnName = "member_id")
    private FamilyMember husband;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "wife_id", referencedColumnName = "member_id")
    private FamilyMember wife;
} 