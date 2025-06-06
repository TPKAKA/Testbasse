package org.g58.vudinhflims.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.NoRepositoryBean;

import java.util.List;

@NoRepositoryBean
public interface BaseRepository<T, ID> extends JpaRepository<T, ID> {

    default List<T> getAll() {
        return findAll();
    }

    default T getById(ID id) {
        return (T) findById(id);
    }

    default T add(T entity) {
        return save(entity);
    }

    default T update(T entity) {
        return save(entity);
    }

    default void delete(T entity) {
        delete(entity);
    }

    default void deleteById(ID id) {
        deleteById(id);
    }
}
