using Casino.DAL.Models;
using System.Threading.Tasks;

namespace Casino.DAL.Respositories {
    public interface IAppRepository {
        Task CreateUser(User user);
        string? GetRefreshToken(int userId);
        Task<User?> GetUserByName(string userName);
        ValueTask<bool> UpdateRefreshToken(int userId, string refreshToken);
    }
}
