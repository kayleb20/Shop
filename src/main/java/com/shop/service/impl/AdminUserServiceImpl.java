package com.shop.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shop.dto.UserLoginDTO;
import com.shop.entity.AdminUser;
import com.shop.repository.AdminUserMapper;
import com.shop.service.AdminUserService;
import com.shop.utils.JwtUtil;
import com.shop.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AdminUserServiceImpl extends ServiceImpl<AdminUserMapper, AdminUser> implements AdminUserService {

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public Result<String> login(UserLoginDTO loginDTO) {
        LambdaQueryWrapper<AdminUser> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AdminUser::getUsername, loginDTO.getUsername());
        AdminUser user = this.getOne(wrapper);

        if (user == null) {
            return Result.error("用户名或密码错误");
        }

        if (!passwordEncoder.matches(loginDTO.getPassword(), user.getPassword())) {
            return Result.error("用户名或密码错误");
        }

        String token = jwtUtil.generateToken(user.getUsername(), "ADMIN");
        return Result.success(token);
    }
}
