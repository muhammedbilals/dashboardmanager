using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using api.models;

namespace api.Migrations
{
    public interface ITokenServices
    {
        string CreateToken(User user);
    }
}