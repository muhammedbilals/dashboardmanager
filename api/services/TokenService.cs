using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Reflection.PortableExecutable;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using api.Migrations;
using api.models;
using Microsoft.EntityFrameworkCore.ValueGeneration.Internal;
using Microsoft.IdentityModel.Tokens;

namespace api.services
{
    public class TokenService : ITokenServices
    {
        private readonly IConfiguration _config;
        private readonly SymmetricSecurityKey _key;
        public TokenService(IConfiguration config)
        {
            _config= config;
            _key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["JWT:SigninKey"]));
        }

        public string CreateToken(User user)
        {
           var Claims = new List<Claim>{
             new Claim(JwtRegisteredClaimNames.Email, user.Email),
             new Claim(JwtRegisteredClaimNames.GivenName, user.Email)
           };

           var creds = new SigningCredentials(_key,SecurityAlgorithms.HmacSha512Signature);

           var tokenDiscriptor = new SecurityTokenDescriptor{
            Subject = new ClaimsIdentity(Claims),
            Expires = DateTime.Now.AddDays(7),
            SigningCredentials = creds,
            Issuer = _config["JWT:Issuer"],
            Audience = _config["JWT:Audience"]
           };

           var tokenHandler = new JwtSecurityTokenHandler();

           var token = tokenHandler.CreateToken(tokenDiscriptor);

           return tokenHandler.WriteToken(token);
        }
    }
}