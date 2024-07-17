SELECT DisplayName
FROM Users
WHERE Id IN (
    SELECT UserId
    FROM (
        SELECT UserId, COUNT(*) AS TotalComments
        FROM Comments
        GROUP BY UserId
    ) AS UserComments
    WHERE TotalComments > 100
);
