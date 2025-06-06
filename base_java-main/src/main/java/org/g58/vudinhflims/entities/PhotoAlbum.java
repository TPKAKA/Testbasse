package org.g58.vudinhflims.entities;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.util.List;

// File: PhotoAlbum.java
@Entity
@Table(name = "photo_album")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@ToString(callSuper = true, exclude = {"photos"})
@EqualsAndHashCode(callSuper = true, exclude = {"photos"})
public class PhotoAlbum extends BaseEntityWithAudit {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "album_id")
    private Long albumID;

    @Column(name = "album_name")
    private String albumName;

    @Column(name = "background_image")
    private String backgroundImage;

    @OneToMany(mappedBy = "album", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Photo> photos;
}
