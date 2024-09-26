using api.models;
using Microsoft.AspNetCore.Identity;
using System.Threading.Tasks;

namespace api.Data
{
    public class DatabaseSeeder
    {
        private readonly UserManager<User> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;

        public DatabaseSeeder(UserManager<User> userManager, RoleManager<IdentityRole> roleManager)
        {
            _userManager = userManager;
            _roleManager = roleManager;
        }

        public async Task SeedAdminUserAsync()
        {
            Console.WriteLine("Starting to seed admin user...");

            if (!await _roleManager.RoleExistsAsync("Admin"))
            {
                Console.WriteLine("Admin role doesn't exist. Creating...");
                var roleResult = await _roleManager.CreateAsync(new IdentityRole("Admin"));
                if (roleResult.Succeeded)
                    Console.WriteLine("Admin role created successfully.");
                else
                    Console.WriteLine($"Failed to create Admin role: {string.Join(", ", roleResult.Errors.Select(e => e.Description))}");
            }

            if (await _userManager.FindByEmailAsync("admin@example.com") == null)
            {
                Console.WriteLine("Admin user doesn't exist. Creating...");
                var adminUser = new User
                {
                    UserName = "admin@example.com",
                    Email = "admin@example.com",
                    EmailConfirmed = true
                };

                var result = await _userManager.CreateAsync(adminUser, "Admin@123456");

                if (result.Succeeded)
                {
                    Console.WriteLine("Admin user created successfully.");
                    var roleResult = await _userManager.AddToRoleAsync(adminUser, "Admin");
                    if (roleResult.Succeeded)
                        Console.WriteLine("Admin role assigned to user successfully.");
                    else
                        Console.WriteLine($"Failed to assign Admin role: {string.Join(", ", roleResult.Errors.Select(e => e.Description))}");
                }
                else
                {
                    Console.WriteLine($"Failed to create admin user. Errors: {string.Join(", ", result.Errors.Select(e => e.Description))}");
                }
            }
            else
            {
                Console.WriteLine("Admin user already exists.");
            }

            Console.WriteLine("Finished seeding admin user.");
        }

    }
}