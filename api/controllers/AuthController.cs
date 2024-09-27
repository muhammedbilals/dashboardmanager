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
    [Route("api/Auth")] // Define the base route for authentication
    [ApiController] // Indicate that this class is an API controller
    public class AuthController : ControllerBase
    {
        private readonly UserManager<User> _userManager; // User manager for handling user operations
        private readonly ITokenServices _tokenService; // Service for token generation and management
        private readonly SignInManager<User> _signinManager; // Sign-in manager for handling user sign-in logic

        // Constructor for dependency injection
        public AuthController(UserManager<User> userManager, ITokenServices tokenServices, SignInManager<User> signInManager)
        {
            _userManager = userManager;
            _tokenService = tokenServices;
            _signinManager = signInManager;
        }

        // Endpoint for user registration
        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterDto registerDto)
        {
            try
            {
                // Validate the model state
                if (!ModelState.IsValid) return BadRequest(ModelState);

                // Create a new user object
                var user = new User
                {
                    Email = registerDto.Email,
                    UserName = registerDto.Email, // Use email as username
                    PhoneNumber = registerDto.MobileNumber // Store mobile number
                };

                // Create the user with the specified password
                var registerdUser = await _userManager.CreateAsync(user, registerDto.Password!);
                if (registerdUser.Succeeded) // Check if user creation was successful
                {
                    // Assign the "USER" role to the new user
                    var roleResult = await _userManager.AddToRoleAsync(user, "USER");
                    if (roleResult.Succeeded)
                    {
                        // Return success response with user details and token
                        return Ok(new NewUserDto
                        {
                            Tokens = _tokenService.CreateToken(user), // Generate JWT token
                            Email = registerDto.Email,
                            UserRole = "User" // Set user role
                        });
                    }
                    else
                    {
                        // Return error if role assignment fails
                        return StatusCode(500, roleResult.Errors);
                    }
                }
                else
                {
                    // Return error if user creation fails
                    return StatusCode(500, registerdUser.Errors);
                }
            }
            catch (Exception e) // Catch any unexpected errors
            {
                return StatusCode(500, e); // Return internal server error
            }
        }

        // Endpoint for user login
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginUserDto loginUserDto)
        {
            // Validate the model state
            if (!ModelState.IsValid) return BadRequest(ModelState);

            // Retrieve the user by email (username)
            var user = await _userManager.Users.FirstOrDefaultAsync(x => x.UserName == loginUserDto.Email);

            // Return unauthorized response if user is not found
            if (user == null) return Unauthorized("Invalid username");

            // Check if the password is correct
            var result = await _signinManager.CheckPasswordSignInAsync(user, loginUserDto.Password, false);
            if (!result.Succeeded) return Unauthorized("Username not found/password incorrect");

            // Retrieve the user's roles
            var roles = await _userManager.GetRolesAsync(user);
            var userRole = roles.FirstOrDefault(); // Get the first role (if any)

            // Return success response with user details and token
            return Ok(
                new NewUserDto
                {
                    Email = user.Email,
                    Tokens = _tokenService.CreateToken(user), // Generate JWT token
                    UserRole = userRole! // Include user role in response
                }
            );
        }
    }
}