BEGIN TRANSACTION;

INSERT INTO championship (
  is_cup
)

VALUES (
    True
),
(
    False
);

COMMIT TRANSACTION;