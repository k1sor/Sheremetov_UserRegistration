using System;
using PasswordHashing;

namespace Sheremetov_UserRegistration
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.Write("Введите пароль пользователя: ");
            string password = Console.ReadLine();

            string passwordHash = PasswordSha256Hasher.GetPasswordHash(password);
            Console.WriteLine("Хешированный пароль пользователя: " + passwordHash);
        }
    }
}
