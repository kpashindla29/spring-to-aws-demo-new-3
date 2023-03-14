package com.ab;


import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertIterableEquals;
import static org.mockito.Mockito.when;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.ab.models.Employee;
@ExtendWith(MockitoExtension.class)
class SpringToAwsDemoNew3ApplicationTests {

	@Mock
	public ResultSet rs;
	
	@Test
	void contextLoads() throws SQLException {
		
		
		when(rs.getString(1)).thenReturn("Hello");
		
		String expected = "Hello";
		
		String actual = rs.getString(1);
		
		assertEquals(expected,actual);
	}
	
	
	@Test
	void compareTwoObjects()  {
		
		Employee e1 = new Employee(1,"Kishore");
		
		Employee e2 = new Employee(1,"Kishore");
		
		
		assertEquals(e1,e2);
	}
	
	@Test
	public void compareTwoLists() {
		
		Employee e1 = new Employee(1,"Kishore");
		
		Employee e2 = new Employee(1,"Kishore");
		
		 List<Employee> actual = Arrays.asList(e1,e2);
		  List<Employee> expected = Arrays.asList(e1,e2);

		  assertIterableEquals(expected, actual);
		
		  List<String> numbers = Arrays.asList("one", "two", "three");
		  List<String> numbers2 = Arrays.asList("one", "two", "three");
		  assertArrayEquals(numbers.toArray(), numbers2.toArray());
		  
		
	}
	
	

}
