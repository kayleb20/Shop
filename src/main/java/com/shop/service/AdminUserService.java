package com.shop.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shop.dto.UserLoginDTO;
import com.shop.entity.AdminUser;
import com.shop.utils.Result;

public interface AdminUserService extends IService<AdminUser> {
    Result<String> login(UserLoginDTO loginDTO);
}
