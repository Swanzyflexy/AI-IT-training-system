from django.shortcuts import render,redirect
from .models import*
from django.contrib import messages
from django.contrib.sessions.models import Session
from django.db import connection
from moviepy.editor import VideoFileClip
import tempfile
from django.db.models import Sum
from django.db.models import ProtectedError
import datetime
import matplotlib.pyplot as plt
import logging
from django.shortcuts import render, redirect, get_object_or_404
# Set up logging
logger = logging.getLogger(__name__)
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from .models import *
from django.db.models import Count
from .gui import *
from django.views import View
from datetime import datetime
from django.shortcuts import redirect
from django.contrib import messages


class Message(View):
    def post(self, request):
        msg = request.POST.get('text')
        print(msg)
        response = chatbot_response(msg)
        print(response)
        
        valid = validators.url(response)
        data1 = 'True' if valid else 'False'
        
        data = {
            'respond': response,
            'respond1': data1,
            'link': response if valid else ''  # Assuming `response` is the URL; adjust if needed
        }
        return JsonResponse(data)

        
def Home(request):
    username = 'Admin'
    password = '12345'
    if AdminDetails.objects.filter(username = username,password = password).exists():
        print('Admin Already Created')
        return render(request,"Home.html",{})
    else:
        AdminDetails.objects.create(username = username,password = password)
        print('Admin data Created')
        return render(request,"Home.html",{})
    return render(request,"Home.html",{})
    

def Admin_Login(request):
    if request.method == "POST":
        A_username = request.POST.get('aname', '').strip()
        A_password = request.POST.get('apass', '').strip()

        # Validate input
        if not A_username or not A_password:
            messages.error(request, 'Username and password are required.')
            return render(request, "Admin_Login.html", {})

        try:
            # Check if user exists and password matches
            admin = AdminDetails.objects.get(username=A_username, password=A_password)
            if admin:
                # Set session data
                request.session['type_id'] = 'Admin'
                request.session['UserType'] = 'Admin'
                request.session['login'] = "Yes"
                messages.info(request, 'Admin login is successful')
                logger.info(f"Admin {A_username} logged in successfully.")
                return redirect("/")
            else:
                messages.error(request, 'Your account is inactive. Please contact support.')
                logger.warning(f"Inactive admin login attempt: {A_username}")
        except AdminDetails.DoesNotExist:
            messages.error(request, 'Error: wrong username or password')
            logger.warning(f"Failed login attempt: {A_username}")

        return render(request, "Admin_Login.html", {})
    else:
        return render(request, "Admin_Login.html", {})

def Manage_Category(request):
    categories = Category.objects.all()
    return render(request, 'Manage_Category.html', {'categories': categories})


def course_enrollment_report(request):
    courses = Course.objects.get_enrollment_stats()
    return render(request, 'course_enrollment_report.html', {'courses': courses})

def student_performance_report(request):
    students = Student.objects.get_completion_stats()
    return render(request, 'student_performance_report.html', {'students': students})

def feedback_report(request):
    students = Student.objects.get_feedback_stats()
    return render(request, 'feedback_report.html', {'students': students})

def add_category(request):
    if request.method == 'POST':
        category_name = request.POST['category_name']
        category_description = request.POST['category_description']

        # Validation (optional)
        if not category_name or not category_description:
            messages.error(request, 'All fields are required.')
            return render(request, 'add_category.html')

        # Save to database
        Category.objects.create(category_name=category_name, category_description=category_description)
        messages.success(request, 'Category added successfully.')
        return redirect('Manage_Category')

    return render(request, 'add_category.html')

def edit_category(request, id):
    categories = get_object_or_404(Category, id=id)
    if request.method == 'POST':
        category_name = request.POST['category_name']
        category_description = request.POST['category_description']

        # Validation (optional)
        if not category_name or not category_description:
            messages.error(request, 'All fields are required.')
            return render(request, 'edit_category.html', {'categories': categories})

        # Update the category
        categories.category_name = category_name
        categories.category_description = category_description
        categories.save()

        messages.success(request, 'Category updated successfully.')
        return redirect('Manage_Category')
    
    return render(request, 'edit_category.html', {'categories': categories})


def edit_subcategory(request,id):
    categories = get_object_or_404(SubCategory, id=id)
    if request.method == 'POST':
        category_name = request.POST['category_name']
        category_description = request.POST['category_description']

        # Validation (optional)
        if not category_name or not category_description:
            messages.error(request, 'All fields are required.')
            return render(request, 'edit_subcategory.html', {'categories': categories})

        # Update the category
        categories.subcategory_name = category_name
        categories.subcategory_description = category_description
        categories.save()

        messages.success(request, 'Category updated successfully.')
        return redirect('Manage_Category')
    
    return render(request, 'edit_subcategory.html', {'categories': categories})


def delete_category(request, id):
    categories = get_object_or_404(Category, id=id)
    print
    
    categories.delete()
    messages.success(request, 'Category deleted successfully.')
       
    return render(request, 'Manage_Category.html', {'categories': categories})

def delete_subcategory(request, id):
    subcategory = get_object_or_404(SubCategory, id=id)
    subcategory.delete()
    messages.success(request, 'Subcategory deleted successfully.')
    
    return redirect('Manage_Category')




def add_subcategory(request):
    if request.method == 'POST':
        category_id = request.POST.get('category_id')
        subcategory_name = request.POST.get('subcategory_name')
        subcategory_description = request.POST.get('subcategory_description')

        # Validate form data
        if not category_id or not subcategory_name or not subcategory_description:
            messages.error(request, 'All fields are required.')
            return redirect('Manage_Category')  # Adjust this to your view name

        try:
            category = Category.objects.get(id=category_id)
        except Category.DoesNotExist:
            messages.error(request, 'Invalid category.')
            return redirect('Manage_Category')  # Adjust this to your view name

        # Create and save the new subcategory
        new_subcategory = SubCategory(
            category=category,
            subcategory_name=subcategory_name,
            subcategory_description=subcategory_description
        )
        new_subcategory.save()

        messages.success(request, 'Subcategory added successfully!')
        return redirect('Manage_Category')  # Adjust this to your view name


    return render(request,'Manage_Category.html',{})


def get_video_duration(video_file):
    try:
        clip = VideoFileClip(video_file)
        duration = clip.duration
        clip.close()
        return duration
    except Exception as e:
        print("Error:", e)
        return None


def Teacher_Login(request):
    if request.method == "POST":
        A_username = request.POST['aname']
        A_password = request.POST['apass']
        if Teacher.objects.filter(username=A_username, password=A_password).exists():
            users = Teacher.objects.all().filter(username=A_username, password=A_password)
            messages.info(request,A_username+ ' logged in')
            request.session['UserId'] = users[0].id
            request.session['type_id'] = 'Teacher'
            request.session['UserType'] = A_username
            request.session['login'] = "Yes"
            return redirect("/")
        else:
            messages.error(request, 'Admin has not registered you yet')
            return redirect("/Teacher_Login")
    else:
        return render(request,'Teacher_Login.html',{})
    return render(request,'Teacher_Login.html',{})


def Student_Login(request):
    if request.method == "POST":
        A_username = request.POST['aname']
        A_password = request.POST['apass']
        if Student.objects.filter(username=A_username, password=A_password).exists():
            users = Student.objects.all().filter(username=A_username, password=A_password)
            messages.info(request,A_username+ ' logged in')
            request.session['UserId'] = users[0].id
            request.session['type_id'] = 'Student'
            request.session['UserType'] = A_username
            request.session['login'] = "Yes"
            return redirect("/")
        else:
            messages.error(request, 'Not Registered')
            return redirect("/Student_Login/")
    else:
        return render(request,'Student_Login.html',{})
    return render(request,'Student_Login.html',{})


def Teacher_Registration(request):
    if request.method == 'POST':
        # Process the form data
        full_name = request.POST.get('full_name')
        email = request.POST.get('email')
        address = request.POST.get('address')
        phone = request.POST.get('phone')
        birth_date = request.POST.get('birth_date')
        gender = request.POST.get('gender')
        username = request.POST.get('username')
        password = request.POST.get('password')

        
        if Teacher.objects.filter(username=username).exists():
            messages.info(request,"Username already exists")
            return  redirect('/User_Management/')

        
        employee = Teacher(
            full_name=full_name,
            email=email,
            phone=phone,
            birth_date=birth_date,
            address=address,
            gender=gender,
            username=username,
            password=password
        )
        employee.save()
        messages.info(request,"User Added successfully")
        return redirect('/User_Management/')
    else:
        return render(request,"Teacher_Registration.html")


def Student_Registration(request):
    if request.method == 'POST':
        # Process the form data
        full_name = request.POST.get('full_name')
        email = request.POST.get('email')
        address = request.POST.get('address')
        phone = request.POST.get('phone')
        birth_date = request.POST.get('birth_date')
        gender = request.POST.get('gender')
        username = request.POST.get('username')
        password = request.POST.get('password')

        
        if Student.objects.filter(username=username).exists():
            messages.info(request,"Username already exists")
            return  redirect('/Student_Registration/')

        
        employee = Student(
            full_name=full_name,
            email=email,
            phone=phone,
            birth_date=birth_date,
            address=address,
            gender=gender,
            username=username,
            password=password
        )
        employee.save()
        messages.info(request,"User Added successfully")
        return redirect('/Student_Login/')
    else:
        return render(request,"Student_Registration.html")

def Manage_Subcategory(request, id):
    # Check if the category exists
    category = get_object_or_404(Category, id=id)
    
    # Get subcategories associated with the category
    subcategories = SubCategory.objects.filter(category=category)
    print(subcategories)
    
    # Prepare context
    context = {
        'category': category,
        'subcategories': subcategories
    }

    # Render template with context
    return render(request, 'Manage_Subcategory.html', context)

def User_Management(request):
    details = Teacher.objects.all()
    return render(request,"User_Management.html",{'details':details})


def Update_Teacher(request):
    if request.method == "POST":
        teacher_id = request.POST.get('viewid')
        details = Teacher.objects.get(id=teacher_id)
        u_name = details.username
        u_pass = details.password
        full_name = request.POST.get('viewname')
        email = request.POST.get('viewage')
        Address = request.POST.get('viewaddress')
        phone = request.POST.get('phone')
        birth_date = request.POST.get('birth_date')
        gender = request.POST.get('gender')
        username = request.POST.get('username')
        password = request.POST.get('password')

        if username:
            pass
        else:
            username = u_name

        if password:
            pass
        else:
            password = u_pass

        name = details.full_name

        print("POST Data:", request.POST)

        print("Teacher Name :",name)
        print("u_name :",u_name)
        print("u_pass :",u_pass)

        print(" teacher_id :",teacher_id)
        print(" full_name:",full_name)
        print(" email:",email)
        print(" Address:",Address)
        print(" phone:",phone)
        print(" birth_date:",birth_date)
        print(" gender:",gender,)
        print(" username:",username)
        print(" password:",password)

        details.full_name = full_name
        details.email = email
        details.Address = Address
        details.phone = phone
        details.birth_date = birth_date
        details.gender = gender
        details.username = username
        details.password = password

        details.save()

        messages.info(request,"Teacher Profile Updated")

    return redirect('/User_Management/')

def Delete_Teacher(request,id):
    Teacher.objects.filter(id=id).delete()
    return redirect('/User_Management/')

def Delete_Course(request, id):
    try:
        # Attempt to delete the course
        Course.objects.filter(id=id).delete()
    except ProtectedError:
        # Handle the case where deletion is not allowed due to protected foreign keys
        messages.info(request, "Cannot delete the course. Students are enrolled in this course.")
    return redirect('/Course_Management/')

def Course_Management(request):
    details = Course.objects.all()
    teachers =  Teacher.objects.all()
    return render(request,"Course_Management.html",{'details':details,'teachers':teachers})
from django.http import JsonResponse
from .models import SubCategory

def get_subcategories(request, category_id):
    subcategories = SubCategory.objects.filter(category_id=category_id).values('id', 'subcategory_name')
    return JsonResponse({'subcategories': list(subcategories)})

def Add_Course(request):
    if request.method == "POST":
        title = request.POST['courseName']
        description = request.POST['Description']
        level = request.POST['level']
        teacher = request.POST['teacher']
        category = request.POST['category']
        subcategory = request.POST['subcategory']

        print("title:", title)
        print("description:", description)
        print("level:", level)
        print("teacher:", teacher)
        print("category:", category)
        print("subcategory:", subcategory)

        teacher_info = Teacher.objects.get(id=teacher)
        category_info = Category.objects.get(id=category)
        subcategory_info = SubCategory.objects.get(id=subcategory)

        obj = Course(
            title=title,
            description=description,
            level=level,
            teacher=teacher_info,
            category=category_info,
            subcategory=subcategory_info
        )
        obj.save()
        messages.success(request, 'Course added successfully.')
        return redirect('/Course_Management/')
    else:
        categories = Category.objects.all()
        teachers = Teacher.objects.all()
        context = {
            'categories': categories,
            'teachers': teachers,
        }
        return render(request, 'add_course.html', context)


def Teacher_Course_Management(request):
    teacher_id = request.session['UserId']
    print("Teacher ID :",teacher_id)
    details = Course.objects.filter(teacher=teacher_id)
    return render(request,"Teacher_Course_Management.html",{'details':details})

def Add_Lectures(request, id):
    if request.method == "POST":
        try:
            lecture_name = request.POST['lecture_name']
            lecture_description = request.POST['Description']
            video_file = request.FILES['video']
            teacher_id = request.session['UserId']

            course = Course.objects.get(id=id)
            teacher = Teacher.objects.get(id=teacher_id)

            existing_lectures_count = Lectures.objects.filter(course=course).count()  # Correct field assignment
            lecture_no = existing_lectures_count + 1

            with tempfile.NamedTemporaryFile(delete=False) as temp_file:
                for chunk in video_file.chunks():
                    temp_file.write(chunk)
                temp_file_path = temp_file.name

            duration = get_video_duration(temp_file_path)
            if duration is not None:
                obj = Lectures(
                    course=course,  # Correct
                    teacher=teacher,  # Correct
                    lecture_no=lecture_no,
                    lecture_name=lecture_name,
                    lecture_description=lecture_description,
                    video_file=video_file,
                    duration=duration
                )
                obj.save()
                messages.success(request, "Lecture successfully added")
            else:
                messages.error(request, "Failed to get the duration of the video.")
        
        except Exception as e:
            messages.error(request, f"An error occurred: {e}")

        return redirect('Teacher_Course_Management')  # Use URL name instead of hardcoded URL
    
    else:
        try:
            course = Course.objects.get(id=id)
            details = Lectures.objects.filter(course=course)
        except Course.DoesNotExist:
            messages.error(request, "Course not found")
            return redirect('some_default_view')  # Redirect to a default view or handle as needed

        return render(request, "Add_Lectures.html", {'course': course.title, 'course_id': id, 'details': details})

def view_teacher_groups(request):
    teacher_id = request.session.get('UserId')  # Use get to avoid KeyError
    if not teacher_id:
        messages.error(request, 'Teacher not authenticated')
        return render(request, 'teacher_groups.html')

    teacher = Teacher.objects.filter(id=teacher_id).first()
    if not teacher:
        messages.error(request, 'Teacher not found')
        return render(request, 'teacher_groups.html')

    groups = Group.objects.filter(course__teacher=teacher).select_related('course__category', 'course__subcategory')
    
    # Organize groups by category and subcategory
    grouped_data = {}
    for group in groups:
        course = group.course
        category = course.category
        subcategory = course.subcategory
        
        if category not in grouped_data:
            grouped_data[category] = {}
        
        if subcategory not in grouped_data[category]:
            grouped_data[category][subcategory] = []
        
        grouped_data[category][subcategory].append(group)

    return render(request, 'teacher_groups.html', {'grouped_data': grouped_data})


def overview_teacher_courses(request):
    teacher_id = request.session.get('UserId')
    print(teacher_id)
    if not teacher_id:
        return redirect('login_view')  # Redirect to login if no teacher ID is in session

    teacher = Teacher.objects.get(id=teacher_id)
    courses = Course.objects.filter(teacher=teacher)

    course_data = []

    for course in courses:
        quizzes = Title.objects.filter(course_id=course)
        assignments = Assignments.objects.filter(course_id=course)
        assignments_submissions = Student_Assignments.objects.filter(Assignment_id__course_id=course)
        quiz_submissions = SubmittedQuiz.objects.filter(title_id__course_id=course)

        course_info = {
            'course': course,
            'quizzes': quizzes,
            'assignments': assignments,
            'assignments_submissions': assignments_submissions,
            'quiz_submissions': quiz_submissions
        }
        course_data.append(course_info)

    return render(request, 'teacher_overview.html', {'course_data': course_data})

def Update_Course(request):
    if request.method == "POST":
        course_id = request.POST['viewid']
        title = request.POST['viewname'].strip()
        description = request.POST['viewage'].strip()
        level = request.POST['level'].strip()
        teacher = request.POST['teacher'].strip()

        teach = Teacher.objects.get(id=teacher)

        course = Course.objects.get(id=course_id)
        course.title = title or course.title
        course.description = description or course.description
        course.level = level or course.level
        course.teacher = teach or course.teacher
        course.save()
    return redirect('/Course_Management/')


def Add_Assignments(request,id):
    print("Course ID :",id)
    data = Course.objects.get(id=id)
    course = data.title
    return render(request,"Add_Assignments.html",{'course':course,'course_id':id})



import random

def View_Course(request):
    # Get the current user's ID
    user_id = request.session.get('UserId')
    print(f"User ID: {user_id}")

    # Get IDs of courses the user is enrolled in
    enrolled_courses = Enrollment.objects.filter(student_id=user_id).values_list('course_id', flat=True)
    print(f"Enrolled Courses: {enrolled_courses}")

    # Get all courses that the user is not enrolled in
    all_courses = Course.objects.exclude(id__in=enrolled_courses)
    print(f"All Courses (excluding enrolled): {all_courses}")

    # Recommend 6 courses
    if all_courses.count() > 6:
        recommended_courses = random.sample(list(all_courses), 6)  # Select 6 random courses
    else:
        recommended_courses = all_courses  # If fewer than 6 courses are available

    # Get additional "You May Like" courses, avoiding recommended and enrolled courses
    remaining_courses = all_courses.exclude(id__in=[course.id for course in recommended_courses])
    you_may_like_courses = remaining_courses[:5]  # Get up to 5 additional courses

    context = {
        'details': Course.objects.filter(id__in=enrolled_courses),
        'recommended_courses': recommended_courses,
        'random_courses': you_may_like_courses
    }

    return render(request, 'View_Course.html', context)



from django.shortcuts import render, redirect
from .models import Course, Lectures, Enrollment, Student
from django.db.models import Sum
from django.contrib import messages

def View_Lectures(request, id):
    print("Course ID:", id)
    
    # Fetch the course using the provided id
    course = Course.objects.get(id=id)
    course_name = course.title
    course_des = course.description
    
    # Get the student ID from the session
    user_id = request.session['UserId']
    student = Student.objects.get(id=user_id)
    
    # Calculate the total duration of all lectures in this course
    total_duration = Lectures.objects.filter(course=course).aggregate(total_duration=Sum('duration'))
    total_duration_value = total_duration['total_duration']
    print("total_duration_value:", total_duration_value)
    
    # Check if the student is enrolled in the course
    if Enrollment.objects.filter(student=student, course=course).exists():
        # Fetch all lectures related to the course
        details = Lectures.objects.filter(course=course)
        return render(request, "View_Lectures.html", {
            'details': details,
            'course_name': course_name,
            'course_des': course_des,
            "total_duration_value": total_duration_value,
            'course_id': id
        })
    else:
        # If not enrolled, show only the first lecture and prompt to enroll
        first_lecture = Lectures.objects.filter(course=course).first()
        details = [first_lecture] if first_lecture else []
        enroll = "Yes"
        return render(request, "View_Lectures.html", {
            'details': details,
            'course_name': course_name,
            'course_des': course_des,
            "total_duration_value": total_duration_value,
            'enroll': enroll,
            'course_id': id
        })



def Update_Lecture(request):
    if request.method == "POST":
        lecture_id = request.POST['id']
        c_id = request.POST['c_id']
        lecture = Lectures.objects.get(id=lecture_id)
        lecture_no = request.POST.get('lecture',lecture.lecture_no)
        lecture_description = request.POST.get('lecture_description',lecture.lecture_description)
        video_file = request.FILES.get('new_video',lecture.video_file)


        with tempfile.NamedTemporaryFile(delete=False) as temp_file:
            for chunk in video_file.chunks():
                temp_file.write(chunk)
            temp_file_path = temp_file.name
        duration = get_video_duration(temp_file_path)

        print("Video Duration in Update Lecture:",duration)
    return redirect('/Add_Lectures/'+str(c_id))


def Delete_Lecture(request,id):
    lecture = Lectures.objects.get(id=id)
    course_id = lecture.course_id.id
    print("Course ID in delete lecture:",course_id)
    Lectures.objects.filter(id=id).delete()
    return redirect('/Add_Lectures/'+str(course_id))







def Enroll(request, id):
    print("Course ID in Enrollment:", id)
    student_id = request.session['UserId']
    print("Student Id :", student_id)

    course = Course.objects.get(id=id)
    student = Student.objects.get(id=student_id)
    
    # Getting the current datetime
    current_time = datetime.now()
    month = current_time.strftime("%B")
    print("Month:", month)
    
    # Creating and saving the enrollment object
    obj = Enrollment(student=student, course=course, month=month)
    obj.save()

    # Updating the enrollment count for the course
    count = course.enrollment_count
    print("Current Course Enrollment Count =", count)
    course.enrollment_count = count + 1
    course.save()
    
    # Adding a success message
    messages.info(request, f"Congratulations! You have enrolled in {course.title}")
    
    # Redirecting to the lectures page
    #return redirect(f'/View_Lectures/{id}')
    return redirect('/View_Course')



def Add_Assignments(request,id):
    if request.method == "POST":
        file = request.FILES['file']
        print("Uploded File :",file)
        course = Course.objects.get(id=id)
        obj = Assignments(course_id=course,teacher_file=file)
        obj.save()
        print("Course ID after Post request :",id)
        return redirect('/Add_Assignments/'+str(id))
    else:
        print("Course ID :",id)
        data = Course.objects.get(id=id)
        course = data.title
        details = Assignments.objects.filter(course_id=id)
        return render(request,"Add_Assignments.html",{'course':course,'course_id':id,'details':details})


def View_Assignments(request,id):
    print("Course ID:",id)
    user_id = request.session['UserId']
    if Enrollment.objects.filter(student=user_id,course=id).exists():
        course = Course.objects.get(id=id)
        details = Assignments.objects.filter(course_id=id)
        data = StudentAssignments.objects.all()
        return render(request,"View_Assignments.html",{'details':details,'course':course,'data':data,'course_id':id})
    else:
        messages.info(request,"You have not enrolled for the course")
        return redirect('/View_Course/')


def Submit_Assignments(request, id):
    asg = get_object_or_404(Assignments, id=id)
    print("Course ID:", asg.course_id.id)
    print("Assignment ID:", id)
    print("File Name:", asg.teacher_file.name)

    course_id = asg.course_id.id
    user_id = request.session.get('UserId')  # safer way to get session data

    if request.method == "POST":
        student_file = request.FILES.get('file')  # safer way to get file from request
        if not student_file:
            messages.error(request, "No file uploaded.")
            return redirect('/View_Assignments/' + str(course_id))

        existing_submission = Student_Assignments.objects.filter(Assignment_id=id, student_id=user_id).exists()
        if existing_submission:
            messages.info(request, "You have already submitted the assignment.")
        else:
            obj = Student_Assignments(Assignment_id=asg, student_file=student_file, student_id=user_id)
            obj.save()
            messages.success(request, "Assignment Submitted Successfully.")
            
            # Check for course completion after assignment submission
            update_course_completion(user_id, course_id)

    return redirect('/View_Assignments/' + str(course_id))


def View_Student_Assignments(request,id):
    print("Assignment ID :",id)
    details = Student_Assignments.objects.filter(Assignment_id=id)
    return render(request,"View_Student_Assignments.html",{'details':details,'Assignment_id':id})


def Update_Remarks(request,id):
    if request.method == "POST":
        A_Id = request.POST['updateid']
        Assignment_id = request.POST['updatename']
        Student_id = request.POST['updateage']
        remarks= request.POST['remarks'].strip()

        Student_Assignments.objects.filter(id =A_Id,Assignment_id=Assignment_id,student_id=Student_id).update(remarks=remarks)
        messages.info(request,"Remarks Submitted")
        return redirect('/View_Student_Assignments/'+str(id))

def Add_Quiz(request,id):
    if request.method == "POST":
        title =  request.POST['title']
        obj = Title(course_id=id,title=title)
        obj.save()
        return redirect('/Add_Quiz/'+str(id))
    else:
        details = Title.objects.filter(course_id=id)
        return render(request,"Add_Quiz.html",{'details':details,'course_id':id})

def Add_Questions(request,id):
    if request.method == "POST":
        question    = request.POST['question']
        option1     = request.POST['Option_1']
        option2     = request.POST['Option_2']
        option3     = request.POST['Option_3']
        option4     = request.POST['Option_4']
        answer      = request.POST['answer']

        title = Title.objects.get(id=id)

        if Questions.objects.filter(title_id=id).count() <= 5:
            obj = Questions(title_id=title,question=question,option1=option1,option2=option2,option3=option3,option4=option4,answer=answer)
            obj.save()
        else:
            messages.info(request,"Quiz capacity reached")
    details = Questions.objects.filter(title_id=id)        
    return render(request,"Add_Questions.html",{'quiz_id':id,'details':details})


def Delete_Quiz(request,id):
    quiz = Title.objects.get(id=id)
    course_id = quiz.course_id

    print("Title ID to be Deleted :",id)
    print("Quiz of course  :",course_id)
    Title.objects.filter(id=id).delete()
    return redirect('/Add_Quiz/'+str(course_id))


def Update_Quiz(request):
    if request.method == "POST":
        question_id  = request.POST['viewid']
        title_id = request.POST['viewname'].strip()
        print("Title ID :",title_id)
        quiz = Questions.objects.get(id=question_id)
        question = request.POST.get('viewage',quiz.question).strip()
        option1 = request.POST.get('viewaddress',quiz.option1).strip()
        option2 = request.POST.get('phone',quiz.option2).strip()
        option3 = request.POST.get('option3',quiz.option3).strip()
        option4 = request.POST.get('option4',quiz.option4).strip()
        answer = request.POST.get('answer',quiz.answer).strip()

        quiz.question = question
        quiz.option1 = option1
        quiz.option2 = option2
        quiz.option3 = option3
        quiz.option4 = option4
        quiz.answer = answer

        quiz.save()
        messages.info(request,"Quiz Updated")
    return redirect('/Add_Questions/'+str(title_id))


def View_Quiz(request,id):
    user_id = request.session['UserId']
    if Enrollment.objects.filter(student=user_id,course=id).exists():
        details = Title.objects.filter(course_id=id)
        return render(request,"View_Quiz.html",{'details':details})
    else:
        messages.info(request,"You have not enrolled for the course")
        return redirect('/View_Course/')


def View_Questions(request,id):
    details = Questions.objects.filter(title_id=id)
    student_list = SubmittedQuiz.objects.filter(title_id=id).values_list('student', flat=True)
    print("Students Attempted Quiz List :",student_list)
    return render(request,"View_Questions.html",{'details':details,'title_id':id})

def Submit_Quiz(request):
    if request.method == "POST":
        title_id = request.POST['title_id']
        user_id = request.session['UserId']
        student = get_object_or_404(Student, id=user_id)
        title = get_object_or_404(Title, id=title_id)

        # Check if the quiz has already been attempted
        if SubmittedQuiz.objects.filter(title=title, student=student).exists():
            messages.info(request, "You have already attempted the quiz.")
        else:
            # Create a new quiz submission
            submission = SubmittedQuiz.objects.create(student=student, title=title)
            
            # Process each question in the quiz
            for question in title.question_set.all():
                selected_option = request.POST.get(f'question_{question.id}')
                answer = get_object_or_404(Answer, question=question, text=selected_option)
                
                # Record the submitted answer and its correctness
                submission.submittedanswer_set.create(question=question, selected_answer=selected_option, correct=answer.correct)

            messages.success(request, "Quiz Submitted")

            # Update course completion status after quiz submission
            update_course_completion(user_id, title.course_id.id)

            # Redirect to a view where the quiz results are displayed
            return redirect('quiz_results', submission_id=submission.id)
            
    return redirect('/View_Questions/' + str(title_id))


def Create_Group(request,id):
    course_id = Course.objects.get(id=id)
    details = Group.objects.filter(course_id=id)
    return render(request,"Create_Group.html",{'course_id':course_id,'details':details})

def Add_Group(request, id):
    try:
        course = Course.objects.get(id=id)
    except Course.DoesNotExist:
        messages.error(request, "Course not found")
        return redirect('/Create_Group/')

    if request.method == "POST":
        group_name = request.POST.get('name', '').strip()
        
        if not group_name:
            messages.error(request, "Group name cannot be empty")
            return redirect('/Create_Group/' + str(course.id))
        
        if Group.objects.filter(course_id=course, group_name=group_name).exists():
            messages.info(request, "Group already exists")
        else:
            Group.objects.create(course=course, group_name=group_name)
            messages.success(request, "Group added successfully")
        
    return redirect('/Create_Group/' + str(course.id))
def enrollment_report(request):
    teacher_id = request.session.get('UserId')  # Using get() to safely access the session variable
    courses = Course.objects.filter(teacher_id=teacher_id)  # Ensure 'teacher' field is correctly referenced
    course_ids = courses.values_list('id', flat=True)

    # Grouping enrollments by month for courses taught by the teacher
    enrollments = Enrollment.objects.filter(course__id__in=course_ids).values('month').annotate(count=Count('id')).order_by('month')

    return render(request, 'enrollment_report.html', {'enrollments': enrollments})
# views.py
def View_Students(request, course_id, group_id):
    try:
        # Fetch group members' IDs if Group_Member model has group_id
        group_members = Group_Member.objects.filter(group_id=group_id).values_list('student_id', flat=True)

        # Fetch details of students enrolled in the course
        details = Enrollment.objects.filter(course_id=course_id).select_related('student')

        # Optionally, filter details to only include students who are in the group
        filtered_details = details.filter(student_id__in=group_members)

        return render(request, "View_Students.html", {
            'details': filtered_details,
            'group_id': group_id,
            'course_id': course_id,
            'group_members': group_members
        })
    except Exception as e:
        # Log the exception if necessary
        print(f"Error: {e}")
        messages.error(request, "Group or Course not found")
        return redirect('/')  # Redirect to a valid page
def Add_Students(request,student_id,group_id,course_id):
    print("In Add Students ")
    print("Student ID :",student_id)
    print("group_id :",group_id)
    print("course_id :",course_id)
    if Group_Member.objects.filter(Group_id=group_id,student=student_id).exists():
        messages.info(request,"Student is already a member of the group")
    else:
        group = Group.objects.get(id=group_id)
        student = Student.objects.get(id=student_id)
        obj = Group_Member(Group_id=group,student=student)
        obj.save()
        messages.info(request,"Student Added to the group")
    return redirect('/View_Students/'+str(course_id)+"/"+str(group_id))


def View_Group_Members(request, group_id):
    try:
        # Fetch the group members based on the group_id
        group_members = Group_Member.objects.filter(group_id=group_id).select_related('student')
        
        # Fetch the group details if needed (optional)
        group = Group.objects.get(id=group_id)

        return render(request, "View_Group_Members.html", {
            'group_members': group_members,
            'group': group
        })
    except Group_Member.DoesNotExist:
        messages.error(request, "Group not found")
        return redirect('/')  # Redirect to a valid page
    except Group.DoesNotExist:
        messages.error(request, "Group details not found")
        return redirect('/')  # Redirect to a valid page



def Progress_Tracking(request, id):
    # Fetch the current user
    current_user = request.session.get('UserId')
    
    if not current_user:
        # Handle the case where the user is not authenticated
        messages.error(request, 'User not authenticated')
        return redirect('/')  # Redirect to a valid page

    # Count the total number of quizzes for the given course
    quiz_count = Title.objects.filter(course_id=id).count()
    print("Total Quiz:", quiz_count)

    # Count the number of quizzes attempted by the current user
    attempted_quiz_count = SubmittedQuiz.objects.filter(student_id=current_user, course_id=id).count()
    print("Attempted Quiz Count:", attempted_quiz_count)

    # Count the number of assignments for the given course
    assignments_count = Assignments.objects.filter(course_id=id).count()
    print("Total Assignments:", assignments_count)

    # Count the number of completed assignments by the current user
    completed_assignment_count = Student_Assignments.objects.filter(student_id=current_user, assignment__course_id=id).count()
    print("Completed Assignment Count:", completed_assignment_count)

    # Calculate percentages
    quiz_percentage = (attempted_quiz_count / quiz_count) * 100 if quiz_count > 0 else 0
    assignment_percentage = (completed_assignment_count / assignments_count) * 100 if assignments_count > 0 else 0

    return render(request, "Progress_Tracking.html", {
        'quiz_percentage': quiz_percentage,
        'assignment_percentage': assignment_percentage
    })

def Progress_Tracking_Teacher(request, id ,course_id):
    # Fetch the current user
    current_user = id
    # current_user = get_object_or_404(User, id=current_user_id)

    # Count the total number of quizzes for the given course
    quiz_count = Title.objects.filter(course_id=course_id).count()
    print("Total Quiz :",quiz_count)

    # Count the number of quizzes attempted by the current user
    attempted_quiz_count = SubmittedQuiz.objects.filter(student=current_user, title_id__course_id=course_id).count()
    print("attempted_quiz_count:",attempted_quiz_count)

    # Count the number of assignments for the given course
    assignments_count = Assignments.objects.filter(course_id=course_id).count()
    print("Toatl Assignment:",assignments_count)

    completed_assignment_count = Student_Assignments.objects.filter(student_id=current_user, Assignment_id__course_id=course_id).count()
    print("completed_assignment_count:",completed_assignment_count)
    # Calculate percentages
    quiz_percentage = (attempted_quiz_count / quiz_count) * 100 if quiz_count > 0 else 0
    assignment_percentage = (completed_assignment_count / assignments_count) * 100 if quiz_count > 0 else 0

    return render(request, "Progress_Tracking.html", {
        'quiz_percentage': quiz_percentage,
        'assignment_percentage': assignment_percentage
    })


def Student_Progress(request,id):
    details = Enrollment.objects.filter(course=id)
    return render(request,"Student_Progress.html",{'details':details,'course_id':id})







def View_Chat(request, group_id):
    try:
        # Fetch group details
        details = Group.objects.get(id=group_id)
        
        # Fetch chat data for the group
        data = Chat.objects.filter(group_id=group_id)
        
        return render(request, "View_Chat.html", {
            'Group_id': group_id,
            'details': details,
            'data': data
        })
    except Group.DoesNotExist:
        messages.error(request, "Group not found")
        return redirect('/')  # Redirect to a valid page
    except Exception as e:
        messages.error(request, f"An error occurred: {e}")
        return redirect('/')  # Redirect to a valid page



def Add_Comment(request):
    if request.method == "POST":
        group_id = request.POST['group_id']
        comment = request.POST['comment']
        user_id = request.session['UserId']
        user = Teacher.objects.get(id=user_id)
        name = user.full_name
        group = Group.objects.get(id=group_id)
        obj = Chat(user=name,group=group,comment=comment)
        obj.save()
    return redirect('/View_Chat/'+str(group_id))


def View_Group(request,id):
    user_id = request.session['UserId']

    details = Group_Member.objects.filter(student=user_id) 

    return render(request,"View_Group.html",{'details':details})


def Show_Monthly_graph(request, course_id):
    # Get the enrollments for the specified course
    enrollments = Enrollment.objects.filter(course_id=course_id)
    
    # Initialize a dictionary to store the count of enrollments for each month
    monthly_enrollments = {}
    
    # Count the number of enrollments for each month
    for enrollment in enrollments:
        month = enrollment.month
        if month in monthly_enrollments:
            monthly_enrollments[month] += 1
        else:
            monthly_enrollments[month] = 1
    
    # Extract months and corresponding counts
    months = list(monthly_enrollments.keys())
    counts = list(monthly_enrollments.values())
    
    # Plotting
    plt.figure(figsize=(10, 6))
    plt.bar(months, counts, color='blue')
    plt.xlabel('Month')
    plt.ylabel('Number of Enrollments')
    plt.title('Monthly Enrollment for Course ID {}'.format(course_id))
    plt.xticks(rotation=45)
    plt.tight_layout()

    # Show the plot directly (pop-up)
    plt.show()
    return redirect('/')

from textblob import TextBlob

def Give_Feedback(request):
    
    
    if request.method == "POST":
        user_id = request.session.get('UserId')
        student = get_object_or_404(Student, id=user_id)
        text = request.POST['feedback'].strip()
        # Create a TextBlob object
        blob = TextBlob(text)

        # Perform sentiment analysis
        sentiment_score = blob.sentiment.polarity

        # Interpret the sentiment
        if sentiment_score > 0:
            sentiment = "Positive"
        elif sentiment_score < 0:
            sentiment = "Negative"
        else:
            sentiment = "Neutral"

        # Create and save the FeedbackData instance
        obj = FeedbackData(feedback=text, sentiment=sentiment, student=student)
        obj.save()

         # Redirect to the same view after saving

        # Fetch all feedbacks
        feedbacks = FeedbackData.objects.all()



        context = {
            'feedbacks': feedbacks,
           
        }

        return render(request, "Give_Feedback.html", context)
    else:
        # Fetch all feedbacks
        feedbacks = FeedbackData.objects.all()



        context = {
            'feedbacks': feedbacks,
           
        }

        return render(request, "Give_Feedback.html", context)


def User_Support(request):
    return render(request,'User_Support.html',{})

def reply_feedback(request, feedback_id):
    if request.session['type_id'] != 'Admin':
        return redirect('Give_Feedback')  # Redirect if the user is not an admin

    feedback = get_object_or_404(FeedbackData, id=feedback_id)
    
    if request.method == "POST":
        reply = request.POST['reply'].strip()
        feedback.admin_reply = reply
        feedback.save()

        return redirect('Give_Feedback')

    return redirect('Give_Feedback')

def Feedback(request):
    if request.method == "POST":
        text = request.POST['feedback'].strip()
        
        # Create a TextBlob object
        blob = TextBlob(text)

        # Perform sentiment analysis
        sentiment_score = blob.sentiment.polarity

        # Interpret the sentiment
        if sentiment_score > 0:
            print("Positive sentiment")
            sentiment = "Positive"
        elif sentiment_score < 0:
            print("Negative sentiment")
            sentiment = "Negative"
        else:
            print("Neutral sentiment")
            sentiment = "Neutral"

        # Get the user session id and fetch the Student instance
        user_id = request.session.get('UserId')
        student = get_object_or_404(Student, id=user_id)

        # Create and save the FeedbackData instance
        obj = FeedbackData(feedback=text, sentiment=sentiment, student=student)
        obj.save()

        # Fetch all feedbacks
        feedbacks = FeedbackData.objects.all().filter(student_id = user_id)
        print(feedbacks)



        context = {
            'feedbacks': feedbacks,
           
        }

        return render(request, "Give_Feedback.html", context)
    else:
        return render(request, "Feedback.html", {})

def chatbot(request):
    return render(request,'chatbot.html',{})


def Logout(request):
    Session.objects.all().delete()
    return redirect("/")

def update_course_completion(student_id, course_id):
    # Check all assignments have been submitted
    assignments_submitted = Student_Assignments.objects.filter(student_id=student_id, Assignment_id__course_id=course_id).count()
    total_assignments = Assignments.objects.filter(course_id=course_id).count()

    # Check all quizzes have been submitted
    quizzes_submitted = SubmittedQuiz.objects.filter(student_id=student_id, title_id__course_id=course_id).count()
    total_quizzes = Title.objects.filter(course_id=course_id).count()

    # Update course completion status
    if assignments_submitted == total_assignments and quizzes_submitted == total_quizzes:
        # Check if a completion record exists
        completion, created = CourseCompletion.objects.get_or_create(student_id=student_id, course_id=course_id)
        if not completion.completed:
            completion.completed = True
            completion.completion_date = timezone.now()
            completion.save()

def recommend_courses(student_id):
    # Find all courses in which the student is enrolled
    enrolled_courses = Enrollment.objects.filter(student_id=student_id)
    completed_lectures = LectureCompletion.objects.filter(student_id=student_id, completed=True)
    completed_assignments = StudentAssignments.objects.filter(student_id=student_id)

    # Extract categories from the enrolled courses
    categories = set()
    for enrollment in enrolled_courses:
        categories.add(enrollment.course.category)

    # Check for any additional insights from completed lectures or assignments
    for lecture in completed_lectures:
        categories.add(lecture.course_id.category)

    for assignment in completed_assignments:
        categories.add(assignment.Assignment_id.course_id.category)

    # Recommend courses from the categories
    recommended_courses = Course.objects.filter(category__in=categories).exclude(
        id__in=enrolled_courses.values_list('course_id', flat=True)
    ).distinct()

    return recommended_courses

def manage_ai_article(request):
    data = Blog.objects.all()
    return render(request, "manage_ai_article.html", {'data': data})


def add_ai_article(request):
    if request.method == 'POST':
        title = request.POST['title']
        slug = request.POST['slug']
        user_id = request.session['UserId']
        content = request.POST['content']
        image = request.FILES.get('image')
        published = 'published' in request.POST  # Check if the published checkbox is checked
        
        # Fetch the Teacher instance using the UserId from the session
        author = get_object_or_404(Teacher, pk=user_id)
        
        # Create the blog post object
        blog = Blog(title=title, slug=slug, author=author, content=content, image=image, published=published)
        
        # Save the blog post to the database
        blog.save()
        
        # Optionally, add a success message
        messages.success(request, 'Blog post created successfully.')
        
        # Redirect to a success page or any desired URL
        return redirect('manage_ai_article')  # Replace with your actual redirect URL name
    
    # If GET request or form is not valid, render the form template
    categories = Category.objects.all()
    subcategories = SubCategory.objects.all()  # You may filter this based on selected category in future
    
    context = {
        'categories': categories,
        'subcategories': subcategories,
    }
    
    return render(request, 'add_ai_article.html', context)
    

def delete_ai_article(request):
    if request.method == "POST":
        article_id = request.POST['id']
        article = get_object_or_404(Blog, id=article_id)
        article.delete()
        messages.success(request, 'AI IT Training Article has been deleted successfully.')
        return redirect('/manage_ai_article')
    else:
        return redirect('/manage_ai_article')

def update_ai_article(request, id):
    article = get_object_or_404(Blog, id=id)
    return render(request, 'update_ai_article.html', {'article': article})

def updated_ai_article(request):
    if request.method == "POST":
        article_id = request.POST['Article_id']
        title = request.POST['Title']
        introduction = request.POST['Introduction']
        content = request.POST['Content']
        example_blog = request.POST['Example_Blog']
        visuals1 = request.FILES.get('Visuals1', None)
        visuals2 = request.FILES.get('Visuals2', None)
        visuals3 = request.FILES.get('Visuals3', None)
        conclusion = request.POST['Conclusion']
        references_sources1 = request.POST['References_Sources1']
        references_sources2 = request.POST['References_Sources2']
        references_sources3 = request.POST['References_Sources3']
        references_sources4 = request.POST['References_Sources4']
        
        article = Blog.objects.get(id=article_id)
        article.Title = title
        article.Introduction = introduction
        article.Content = content
        article.Example_Blog = example_blog
        if visuals1:
            article.Visuals1 = visuals1
        if visuals2:
            article.Visuals2 = visuals2
        if visuals3:
            article.Visuals3 = visuals3
        article.Conclusion = conclusion
        article.References_Sources1 = references_sources1
        article.References_Sources2 = references_sources2
        article.References_Sources3 = references_sources3
        article.References_Sources4 = references_sources4
        article.save()
        
        messages.info(request, "AI IT Training Article Updated")
        return redirect('/manage_ai_article')
    else:
        return redirect('/manage_ai_article')

def Analytics_and_Reporting(request):
    courses = Course.objects.all()
    course_labels = [course.title for course in courses]
    course_enrollment_counts = [course.enrollment_count for course in courses]

    students = Student.objects.all()
    student_names = [student.full_name for student in students]
    avg_scores = [student.calculate_avg_score() for student in students]
    feedback_counts = [student.FeedbackData.count() for student in students]
    avg_sentiments = [student.calculate_avg_sentiment() for student in students]

    context = {
        'course_labels': course_labels,
        'course_enrollment_counts': course_enrollment_counts,
        'student_names': student_names,
        'avg_scores': avg_scores,
        'feedback_counts': feedback_counts,
        'avg_sentiments': avg_sentiments,
    }

    return render(request, 'Analytics_and_Reporting.html', context)
