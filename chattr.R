library(chattr)
my_chat <- ellmer::chat_openai()
chattr_use(my_chat)

chattr::chattr_app(as_job = TRUE)


