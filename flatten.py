with open("AllCandidates.complete.annotated.csv") as file:
    lines = [line.rstrip() for line in file]

persons = []
partyMap = {}
answerMap = {}
for line in lines[1:]:
    fields = line.split(",")
    party = fields[0].strip()
    person = fields[1].strip()
    question = fields[2].strip()
    answer = fields[3].strip()
    if person not in persons:
        persons.append(person)
    key = person + "-" + question
    value = answer
    answerMap[key] = value
    partyMap[person] = party

header = "Parti, Person"
for i in range(1, 26):
    header += ", q" + str(i)

print(header)
for person in persons:
    fields = ""
    for i in range(1, 26):
        fields += ", " + answerMap[str(person) + "-" + str(i)]

    print(partyMap[person] + ", " + person + fields)
