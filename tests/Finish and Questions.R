library(ProjectTemplate)
load.project()

#1) How Many Times For Each Course Does a Learner Start a Section, But Not finish It?

#1a)How many times per learner?

Incomplete_Quantity7= cyber.security.7.step.activity %>% filter(last_completed_at == "") %>% count(learner_id) %>% arrange(-n)
IncompleteDF = data.frame(Course1 = nrow(Incomplete_Quantity1),Course2 = nrow(Incomplete_Quantity2),
                          Course3 = nrow(Incomplete_Quantity3),Course4 = nrow(Incomplete_Quantity4),
                          Course5 = nrow(Incomplete_Quantity5),Course6 = nrow(Incomplete_Quantity6),
                          Course7 = nrow(Incomplete_Quantity7))


Incomplete_ID = Incomplete_Quantity7$learner_id

l = length(Incomplete_ID)

(Incomplete_Quantity7$learner_id[9])

QuestionsQuery = vector()
for(i in 1:l){
Questions = (cyber.security.7.question.response %>% filter(learner_id == ((Incomplete_ID[7])[1])))


cyber.security.7.question.response$learner_id [7]

QuestionsQuery[1]= nrow(Questions)
}

New = merge(cyber.security.7.question.response, Incomplete_Quantity7, by = "learner_id")

New = New%>%filter(n != "")
New #dataframe = includes number of unfinished steps for each learner ID


Answers= cyber.security.7.question.response %>% filter(correct == "true") %>% count(learner_id) %>% arrange(-n)
Attempts =cyber.security.7.question.response %>% count(learner_id) %>% arrange(-n)
Unfinished = data.frame(learner_id = New$learner_id, Unfinished = New$n)
Unfinished = unique.data.frame(Unfinished)

UnfinishedQuestions = merge(Unfinished,Answers, by = "learner_id", all = TRUE)
UnfinishedQuestions = UnfinishedQuestions%>% rename(Correct_Answers = n)
UnfinishedQuestions = merge(UnfinishedQuestions,Attempts, by = "learner_id", all = TRUE)
UnfinishedQuestions = UnfinishedQuestions%>% rename(Quant_Attempts = n)

ProportionCorrect = (UnfinishedQuestions$Correct_Answers/UnfinishedQuestions$Quant_Attempts)*100

UnfinishedQuestions = cbind(UnfinishedQuestions, ProportionCorrect)

UnfinishedQuestions<-UnfinishedQuestions[,-c(5)]

T = ggplot(data = UnfinishedQuestions, aes(x = Unfinished, y = Proportion_Correct))
T1 = T + geom_point(aes(x = Unfinished, y = ProportionCorrect))

T1


