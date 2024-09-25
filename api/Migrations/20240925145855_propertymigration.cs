using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace api.Migrations
{
    /// <inheritdoc />
    public partial class propertymigration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "9f58ffd7-f911-49ed-8917-36af8b3ff61d");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "e5ce5915-15f3-4150-bf71-34c714a4ed3e");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "6bc128ef-842a-4fe2-9e13-27fe1afa5d51", null, "Admin", "ADMIN" },
                    { "846bf41f-9cb4-4959-9a3f-d872393f9b2f", null, "User", "USER" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "6bc128ef-842a-4fe2-9e13-27fe1afa5d51");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "846bf41f-9cb4-4959-9a3f-d872393f9b2f");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "9f58ffd7-f911-49ed-8917-36af8b3ff61d", null, "User", "USER" },
                    { "e5ce5915-15f3-4150-bf71-34c714a4ed3e", null, "Admin", "ADMIN" }
                });
        }
    }
}
