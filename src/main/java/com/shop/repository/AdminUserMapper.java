package com.shop.repository;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.shop.entity.AdminUser;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminUserMapper extends BaseMapper<AdminUser> {
}
