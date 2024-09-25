using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.dtos.user;
using api.models;

namespace api.mappers
{
    public static class UserMappers
    {
        public static UserDto ToUserDto (this User user)
        {
            return new UserDto{
                    Id = user.Id,
                 Email =user.Email,
                 Name =user.UserName
            };
        }

        public static User ToLoginDto (this LoginUserDto userDto ){
            return new User{
                Email =userDto.Email,
                PasswordHash =userDto.Password
            };
        }
    }
}