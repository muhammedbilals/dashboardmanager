using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.data;
using api.dtos.user;
using api.interfaces;
using api.mappers;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace api.controllers
{
    [Route("api/user")]
    [ApiController]

    public class UserController: ControllerBase {
        
    private readonly IUserRepository _userRepo;
    // private readonly ICollegeRepository _collegeRepo;

       public UserController(IUserRepository userRepo)
       {
            _userRepo =userRepo;
            // _collegeRepo = collegeRepo;
       }

       [HttpGet("getusers")]
        public async Task<IActionResult> GetUsers(){

            var User = await _userRepo.GetUsers();
            var UserDto = User.Select(s => s.ToUserDto());

            return Ok(UserDto);
        }
    }
}
