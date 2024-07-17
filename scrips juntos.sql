-- 1. Usuarios con mayor reputación
SELECT DisplayName, Location, Reputation
FROM Users
ORDER BY Reputation DESC;

-- 2. Título de los posts y el nombre del usuario que los publicó
SELECT Posts.Title, Users.DisplayName
FROM Posts
JOIN Users ON Posts.OwnerUserId = Users.Id
WHERE Posts.OwnerUserId IS NOT NULL;

-- 3. Promedio de Score de los Posts por cada usuario
SELECT Users.DisplayName, AVG(Posts.Score) AS AverageScore
FROM Posts
JOIN Users ON Posts.OwnerUserId = Users.Id
GROUP BY Users.DisplayName;

-- 4. Usuarios que han realizado más de 100 comentarios
SELECT DisplayName
FROM Users
WHERE Id IN (
    SELECT UserId
    FROM Comments
    GROUP BY UserId
    HAVING COUNT(*) > 100
);

-- 5. Actualizar la columna Location de la tabla Users
UPDATE Users
SET Location = 'Desconocido'
WHERE Location IS NULL OR Location = '';

-- 6. Eliminar comentarios de usuarios con menos de 100 de reputación
DELETE FROM Comments
WHERE UserId IN (
    SELECT Id
    FROM Users
    WHERE Reputation < 100
);

-- 7. Total de publicaciones, comentarios y medallas por usuario
SELECT u.DisplayName AS DisplayName,
       COALESCE(tp.TotalPosts, 0) AS TotalPosts,
       COALESCE(tc.TotalComments, 0) AS TotalComments,
       COALESCE(tb.TotalBadges, 0) AS TotalBadges
FROM Users u
LEFT JOIN (
    SELECT OwnerUserId, COUNT(*) AS TotalPosts
    FROM Posts
    GROUP BY OwnerUserId
) tp ON u.Id = tp.OwnerUserId
LEFT JOIN (
    SELECT UserId, COUNT(*) AS TotalComments
    FROM Comments
    GROUP BY UserId
) tc ON u.Id = tc.UserId
LEFT JOIN (
    SELECT UserId, COUNT(*) AS TotalBadges
    FROM Badges
    GROUP BY UserId
) tb ON u.Id = tb.UserId
ORDER BY u.DisplayName;

-- 8. Las 10 publicaciones más populares
SELECT TOP 10 Title, Score
FROM Posts
ORDER BY Score DESC;

-- 9. Los 5 comentarios más recientes
SELECT TOP 5 Text, CreationDate
FROM Comments
ORDER BY CreationDate DESC;
