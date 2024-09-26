using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.dtos.user;
using api.Migrations;
using api.models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace api.controllers
{
    [Route("api/Auth")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly UserManager<User> _userManager;
        private readonly ITokenServices _tokenService;
        private readonly SignInManager<User> _signinManager;
        public AuthController(UserManager<User> userManager,ITokenServices tokenServices,SignInManager<User> signInManager)
        {
            _userManager = userManager;
            _tokenService = tokenServices;
            _signinManager = signInManager;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register ([FromBody]RegisterDto registerDto ){
            try {
                if(!ModelState.IsValid) return BadRequest(ModelState);

                var user = new User{
                    Email = registerDto.Email,
                    UserName = registerDto.Email,
                    PhoneNumber = registerDto.MobileNumber
                };

                var registerdUser =await _userManager.CreateAsync(user , registerDto.Password!);
                if(registerdUser.Succeeded){
                    var roleResult = await _userManager.AddToRoleAsync(user, "USER");
                    if(roleResult.Succeeded){
                        return Ok(new NewUserDto{
                           Tokens =_tokenService.CreateToken(user),
                            Email = registerDto.Email,
                            
                        });
                    }else{
                        return StatusCode(500,roleResult.Errors);
                    }
                }else {
                    return StatusCode(500,registerdUser.Errors);
                }
            }
            catch (Exception e)
            {
                
               return StatusCode(500 ,e);
            }
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginUserDto loginUserDto){

            if(!ModelState.IsValid) return BadRequest(ModelState);

            var user = await _userManager.Users.FirstOrDefaultAsync(x => x.UserName == loginUserDto.Email);

            if(user== null) return Unauthorized("Invalid username");

            var result = await _signinManager.CheckPasswordSignInAsync(user, loginUserDto.Password ,false);

            if(!result.Succeeded) return Unauthorized("Username not found/password incorrect");

            return Ok(
                new NewUserDto{
                    Email = user.Email,
                    Tokens = _tokenService.CreateToken(user)
                }
            );
        }
    }
}