using System;
using System.Linq;
using PasswordHashing;
using Sheremetov_UserRegistration.Model;

namespace Sheremetov_UserRegistration
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Создание новой учетной записи для пользователя");
            Console.WriteLine();

            Console.Write("Введите имя пользователя: ");
            string firstName = Console.ReadLine();

            Console.Write("Введите фамилию пользователя: ");
            string lastName = Console.ReadLine();

            Console.Write("Введите логин пользователя: ");
            string login = Console.ReadLine();

            Console.Write("Введите пароль пользователя: ");
            string password = Console.ReadLine();

            string passwordHash = PasswordSha256Hasher.GetPasswordHash(password);
            Console.WriteLine("Хешированный пароль пользователя: " + passwordHash);

            using (LibraryModelEntities libraryContext = new LibraryModelEntities())
            {
                Roles readerRole = libraryContext.Roles.First(role => role.Name == "Читатель");

                Readers newReader = new Readers
                {
                    FullName = lastName + " " + firstName,
                    RegistrationDate = DateTime.Today
                };

                libraryContext.Readers.Add(newReader);
                libraryContext.SaveChanges();

                Users newUser = new Users
                {
                    Login = login,
                    PasswordHash = passwordHash,
                    RoleID = readerRole.RoleID,
                    ReaderID = newReader.ReaderID,
                    CreatedAt = DateTime.Now
                };

                libraryContext.Users.Add(newUser);
                libraryContext.SaveChanges();
            }

            Console.WriteLine("Учетная запись добавлена");
        }
    }
}
