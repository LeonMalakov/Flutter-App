using Casino.Utils;
using System.Threading.Tasks;

namespace Casino.Services {
    public interface IAuthService {
        ValueTask<(bool Success, JwtTokenPair TokenPair)> LogIn(string userName, string password);
        ValueTask<(bool Success, JwtTokenPair TokenPair)> Refresh(int userId, string refreshToken);
        ValueTask<(bool Success, JwtTokenPair TokenPair)> SignUp(string userName, string password);
    }
}
