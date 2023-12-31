package es.jacaranda.model;

import java.sql.Date;
import java.util.List;
import java.util.Objects;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "employee")
public class Employee {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	
	private int id;
	private String firstName;
	private String lastName;
	private String email;
	private String gender;
	private Date dateOfBirth;
	private String password;
	private String role;
	@ManyToOne
	@JoinColumn(name="idCompany")
	private Company company;
	
	@OneToMany(mappedBy = "employee")
	private List<EmployeeProject> employeeProject;
	
	public Employee(int id, String firstName, String lastName, String email, String gender, Date dateOfBirth,
			Company company) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.gender = gender;
		this.dateOfBirth = dateOfBirth;
		this.company = company;
	}
	
	public Employee(String firstName, String lastName, String email, String gender, Date dateOfBirth,
			Company company) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.gender = gender;
		this.dateOfBirth = dateOfBirth;
		this.company = company;
	}

	public Employee( String firstName, String lastName, String email, String gender, Date dateOfBirth,
			String password, String role, Company company) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.gender = gender;
		this.dateOfBirth = dateOfBirth;
		this.password = password;
		this.role = role;
		this.company = company;
	}
	

	public Employee(int id, String firstName, String lastName, String email, String gender, Date dateOfBirth,
			String password, Company company, String role) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.gender = gender;
		this.dateOfBirth = dateOfBirth;
		this.password = password;
		this.company = company;
		this.role = role;
	}

	public Employee() {
		super();
	}
	
	

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public List<EmployeeProject> getEmployeeProject() {
		return employeeProject;
	}

	public void setEmployeeProject(List<EmployeeProject> employeeProject) {
		this.employeeProject = employeeProject;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Employee other = (Employee) obj;
		return id == other.id;
	}
	
	

	
}
