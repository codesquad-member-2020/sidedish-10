package com.codesquad.sidedish10.getter.domain;

import org.springframework.data.jdbc.repository.query.Modifying;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends CrudRepository<User, Long> {

  @Modifying
  @Query("INSERT INTO user (userId, name, email) VALUES (:userId, :name, :email)")
  void insertUser(@Param("userId") String userId, @Param("name") String name,
      @Param("email") String email);

  @Modifying
  @Query("SELECT EXISTS (SELECT * FROM user WHERE userId = :userId)")
  int findUserExistenceByUserId(@Param("userId") String userId);

  @Modifying
  @Query("SELECT * FROM USER WHERE userId = :userId")
  User findUserByUserId(@Param("userId") String userId);
}
