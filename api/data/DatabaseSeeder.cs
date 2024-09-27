using api.models;
using Microsoft.AspNetCore.Identity;
using System.Threading.Tasks;

namespace api.Data
{
    public class DatabaseSeeder
    {
        private readonly UserManager<User> _userManager; // User manager for handling user-related operations
        private readonly RoleManager<IdentityRole> _roleManager; // Role manager for handling role-related operations

        // Constructor for dependency injection
        public DatabaseSeeder(UserManager<User> userManager, RoleManager<IdentityRole> roleManager)
        {
            _userManager = userManager; // Assign the user manager to the private field
            _roleManager = roleManager; // Assign the role manager to the private field
        }

        // Method to seed the admin user into the database
        public async Task SeedAdminUserAsync()
        {
            Console.WriteLine("Starting to seed admin user...");

            // Check if the "Admin" role already exists in the database
            if (!await _roleManager.RoleExistsAsync("Admin"))
            {
                Console.WriteLine("Admin role doesn't exist. Creating...");
                // Create the "Admin" role if it doesn't exist
                var roleResult = await _roleManager.CreateAsync(new IdentityRole("Admin"));
                if (roleResult.Succeeded)
                    Console.WriteLine("Admin role created successfully.");
                else
                    // Log any errors that occurred during role creation
                    Console.WriteLine($"Failed to create Admin role: {string.Join(", ", roleResult.Errors.Select(e => e.Description))}");
            }

            // Check if the admin user already exists by email
            if (await _userManager.FindByEmailAsync("admin@example.com") == null)
            {
                Console.WriteLine("Admin user doesn't exist. Creating...");
                // Create a new admin user
                var adminUser = new User
                {
                    UserName = "admin@example.com", // Set the username
                    Email = "admin@example.com", // Set the email
                    EmailConfirmed = true // Confirm the email for the user
                };

                // Create the admin user with a specified password
                var result = await _userManager.CreateAsync(adminUser, "Admin@123456");

                if (result.Succeeded)
                {
                    Console.WriteLine("Admin user created successfully.");
                    // Assign the "Admin" role to the new admin user
                    var roleResult = await _userManager.AddToRoleAsync(adminUser, "Admin");
                    if (roleResult.Succeeded)
                        Console.WriteLine("Admin role assigned to user successfully.");
                    else
                        // Log any errors that occurred during role assignment
                        Console.WriteLine($"Failed to assign Admin role: {string.Join(", ", roleResult.Errors.Select(e => e.Description))}");
                }
                else
                {
                    // Log any errors that occurred during user creation
                    Console.WriteLine($"Failed to create admin user. Errors: {string.Join(", ", result.Errors.Select(e => e.Description))}");
                }
            }
            else
            {
                // Notify that the admin user already exists
                Console.WriteLine("Admin user already exists.");
            }

            Console.WriteLine("Finished seeding admin user.");
        }
    }
}
