from django.db import models
from django.db.models import Count, Avg
from datetime import datetime

class CourseManager(models.Manager):
    def get_enrollment_stats(self):
        return self.annotate(
            total_enrollments=Count('enrollment')
        )


class StudentManager(models.Manager):
    def get_completion_stats(self):
        return self.annotate(
            avg_score=Avg('submitted_quizzes__score')  # Use related name 'submitted_quizzes'
        )

    def get_feedback_stats(self):
        return self.annotate(
            feedback_count=Count('FeedbackData'),  # Use related name 'FeedbackData'
            avg_sentiment=Avg('FeedbackData__sentiment')  # Use related name 'FeedbackData'
        )

class AdminDetails(models.Model):
    username = models.CharField(max_length=100, default=None)
    password = models.CharField(max_length=100, default=None)

    class Meta:
        db_table = 'AdminDetails'


class Teacher(models.Model):
    full_name = models.CharField(max_length=100, null=True)
    email = models.EmailField(null=True)
    address = models.CharField(max_length=200, default=None, null=True)
    phone = models.CharField(max_length=15, null=True)
    birth_date = models.DateField(null=True)
    gender = models.CharField(max_length=10, null=True)
    username = models.CharField(max_length=100, null=True)
    password = models.CharField(max_length=100, null=True)

    class Meta:
        db_table = 'Teacher'


class AITrainingArticle(models.Model):
    title = models.CharField(max_length=255, null=True, blank=True)
    introduction = models.TextField(max_length=155500, null=True, blank=True)
    content = models.TextField(max_length=155500, null=True, blank=True)
    example_blog = models.TextField(max_length=155500, null=True, blank=True)
    visuals1 = models.ImageField(upload_to="images/", null=True, blank=True)
    visuals2 = models.ImageField(upload_to="images/", null=True, blank=True)
    visuals3 = models.ImageField(upload_to="images/", null=True, blank=True)
    conclusion = models.TextField(max_length=155500, null=True, blank=True)
    references_sources1 = models.TextField(max_length=155500, null=True, blank=True)
    references_sources2 = models.TextField(max_length=155500, null=True, blank=True)
    references_sources3 = models.TextField(max_length=155500, null=True, blank=True)
    references_sources4 = models.TextField(max_length=155500, null=True, blank=True)

    class Meta:
        db_table = "AITrainingArticle"


class Category(models.Model):
    category_name = models.CharField(max_length=100, null=True)
    category_description = models.TextField(null=True)

    class Meta:
        db_table = 'Category'


class SubCategory(models.Model):
    category = models.ForeignKey(Category, related_name='subcategories', on_delete=models.CASCADE)
    subcategory_name = models.CharField(max_length=100, null=True)
    subcategory_description = models.TextField(null=True)

    class Meta:
        db_table = 'SubCategory'


class Course(models.Model):
    category = models.ForeignKey(Category, on_delete=models.CASCADE, related_name='courses')
    subcategory = models.ForeignKey(SubCategory, on_delete=models.CASCADE, related_name='courses')
    title = models.CharField(max_length=100, default='Untitled Course', null=True)
    description = models.TextField()
    level = models.CharField(max_length=20, default='Beginner')
    teacher = models.ForeignKey(Teacher, on_delete=models.SET_NULL, null=True, related_name='courses')
    enrollment_count = models.IntegerField(default=0)

    objects = CourseManager()

    class Meta:
        db_table = "Course"


class Student(models.Model):
    full_name = models.CharField(max_length=100)
    email = models.EmailField()
    address = models.CharField(max_length=100, default=None, null=True)
    phone = models.CharField(max_length=15)
    birth_date = models.DateField()
    gender = models.CharField(max_length=10)
    username = models.CharField(max_length=100)
    password = models.CharField(max_length=100)

    objects = StudentManager()

    def calculate_avg_score(self):
        avg_score = self.submitted_quizzes.aggregate(Avg('score'))['score__avg']
        return avg_score if avg_score is not None else 0

    def calculate_avg_sentiment(self):
        avg_sentiment = self.FeedbackData.aggregate(Avg('sentiment'))['sentiment__avg']
        return avg_sentiment if avg_sentiment is not None else 0

    class Meta:
        db_table = 'Student'



class Lectures(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    teacher = models.ForeignKey(Teacher, on_delete=models.SET_NULL, null=True)
    lecture_no = models.IntegerField(null=True, blank=True)
    lecture_name = models.CharField(max_length=100, null=True, blank=True)
    lecture_description = models.TextField()
    video_file = models.FileField(upload_to='lecture_videos/')
    duration = models.CharField(max_length=100)
    add_date = models.DateTimeField(null=True, blank=True)
    last_update = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = "Lectures"


class Enrollment(models.Model):
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    course = models.ForeignKey(Course, on_delete=models.PROTECT)
    month = models.CharField(max_length=100, default=None, null=True)

    class Meta:
        db_table = "Enrollment"


class Interest(models.Model):
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    subcategory = models.ForeignKey(SubCategory, on_delete=models.CASCADE)

    class Meta:
        db_table = "Interest"


class Assignments(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    teacher_file = models.FileField(upload_to='assignment_files/')

    class Meta:
        db_table = "Assignments"


class Student_Assignments(models.Model):
    assignment = models.ForeignKey(Assignments, on_delete=models.CASCADE, null=True)
    student_file = models.FileField(upload_to='student_assignment_files/')
    student_id = models.CharField(max_length=100)
    remarks = models.CharField(max_length=200, null=True)

    class Meta:
        db_table = "Student_Assignments"


class Title(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name='titles')
    title = models.CharField(max_length=200, null=True)

    class Meta:
        db_table = "Title"


class Questions(models.Model):
    title = models.ForeignKey(Title, on_delete=models.CASCADE, null=True)
    question = models.CharField(max_length=100, default=None, null=True)
    option1 = models.CharField(max_length=100, default=None, null=True)
    option2 = models.CharField(max_length=100, default=None, null=True)
    option3 = models.CharField(max_length=100, default=None, null=True)
    option4 = models.CharField(max_length=100, default=None, null=True)
    answer = models.CharField(max_length=100, default=None, null=True)

    class Meta:
        db_table = "Questions"


class Group(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    group_name = models.CharField(max_length=100)

    class Meta:
        db_table = "Group"


class Group_Member(models.Model):
    group = models.ForeignKey(Group, on_delete=models.CASCADE)
    student = models.ForeignKey(Student, on_delete=models.CASCADE)

    class Meta:
        db_table = "Group_Member"


class Chat(models.Model):
    user = models.CharField(max_length=200, default=None, null=True)
    group = models.ForeignKey(Group, on_delete=models.CASCADE, null=True)
    comment = models.CharField(max_length=200, default=None, null=True)

    class Meta:
        db_table = "Chat"


class SubmittedQuiz(models.Model):
    student = models.ForeignKey(Student, on_delete=models.CASCADE, related_name='submitted_quizzes')
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name='submitted_quizzes',default = None)
    quiz = models.CharField(max_length=100)
    score = models.IntegerField()
    submitted_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "SubmittedQuiz"


class FeedbackData(models.Model):
    student = models.ForeignKey(Student, on_delete=models.CASCADE, related_name='FeedbackData')
    feedback = models.CharField(max_length=100, default=None, null=True)
    sentiment = models.CharField(max_length=100, default=None, null=True)
    remarks = models.CharField(max_length=100, default=None, null=True)
    admin_reply = models.TextField(default="", blank=True) 

    class Meta:
        db_table = "FeedbackData"


class Blog(models.Model):
    title = models.CharField(max_length=255)
    slug = models.SlugField(unique=True, help_text="URL friendly version of the title")
    author = models.ForeignKey(Teacher, on_delete=models.CASCADE)
    content = models.TextField()
    image = models.ImageField(upload_to='blog_images/', null=True, blank=True)
    published_date = models.DateTimeField(auto_now_add=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    categories = models.ManyToManyField('Category', related_name='blogs', blank=True)
    tags = models.ManyToManyField('Tag', related_name='blogs', blank=True)
    views = models.IntegerField(default=0)

    class Meta:
        db_table = "Blog"

class Tag(models.Model):
    name = models.CharField(max_length=50, unique=True)

    class Meta:
        db_table = "Tag"
