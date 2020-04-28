package com.codesquad.sidedish10.getter.repository;

import com.codesquad.sidedish10.getter.domain.User;
import org.springframework.data.jdbc.repository.query.Modifying;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends CrudRepository<User, Long> {

  @Modifying
  @Query("INSERT INTO user (userId, name, email) VALUES (:userId, :name, :email)")
  void insertUser(@Param("userId") String userId, @Param("name") String name,
      @Param("email") String email);

  @Query("SELECT EXISTS (SELECT * FROM user WHERE user_id = :user_id)")
  int findUserExistenceByUserId(@Param("user_id") String userId);

  @Query("SELECT * FROM user WHERE user_id = :user_id")
  User findUserByUserId(@Param("user_id") String user_id);
}
