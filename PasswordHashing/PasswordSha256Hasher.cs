using System;
using System.Security.Cryptography;
using System.Text;

namespace PasswordHashing
{
    /// <summary>
    /// Класс для хеширования паролей.
    /// </summary>
    public static class PasswordSha256Hasher
    {
        /// <summary>
        /// Возвращает SHA256-хеш пароля в виде строки из шестнадцатеричных символов.
        /// </summary>
        /// <param name="password">Пароль, который нужно захешировать.</param>
        /// <returns>Хеш пароля.</returns>
        public static string GetPasswordHash(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] passwordBytes = Encoding.UTF8.GetBytes(password);
                byte[] hashBytes = sha256.ComputeHash(passwordBytes);

                return BitConverter.ToString(hashBytes).Replace("-", string.Empty);
            }
        }
    }
}
