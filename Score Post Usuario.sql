SELECT Users.DisplayName, AVG(Posts.Score) AS AverageScore
FROM Posts
JOIN Users ON Posts.OwnerUserId = Users.Id
GROUP BY Users.DisplayName;
