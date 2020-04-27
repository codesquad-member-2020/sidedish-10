package com.codesquad.sidedish10.getter.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

@Table("user")
public class User {

  @Id
  private Long id;
  @Column("user_id")
  private String userId;
  private String name;
  private String email;

  public User(String userId, String name, String email) {
    this.userId = userId;
    this.name = name;
    this.email = email;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getUserId() {
    return userId;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public static User create(String userId, String name, String email) {
    return new User(userId, name, email);
  }
}
