import random
import time

answers = [
    "It is certain.",
    "It is decidedly so.",
    "Without a doubt.",
    "Yes - definitely.",
    "You may rely on it.",
    "As I see it, yes.",
    "Most likely.",
    "Outlook good.",
    "Yes.",
    "Signs point to yes.",
    "Reply hazy, try again.",
    "Ask again later.",
    "Better not tell you now.",
    "Cannot predict now.",
    "Concentrate and ask again.",
    "Don't count on it.",
    "My reply is no.",
    "My sources say no.",
    "Outlook not so good.",
    "Very doubtful."
]


def give_answer():
    return random.choice(answers)


if __name__ == '__main__':
    question = input("Concentrate and write your question: ")
    print("8ball is thinking...")
    time.sleep(3)
    print('*' * 30)
    print('*{: ^28}*'.format('8ball says:'))
    print('*{: ^28}*'.format(give_answer()))
    print('*' * 30)
