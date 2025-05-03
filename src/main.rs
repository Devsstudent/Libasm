use std::ffi::c_void;
use std::ptr::null_mut;

type ComparisonFunction = unsafe fn(*mut c_void, *mut c_void) -> i32;

#[repr(C)]
struct Node {
    data: *mut c_void,
    next: *mut Node,
}

unsafe fn cmp<T: Ord + Copy>(a: *mut c_void, b: *mut c_void) -> i32 {
    let a = *(a as *mut T);
    let b = *(b as *mut T);
    a.cmp(&b) as i32
}

#[link(name = "asm")]
extern "C" {
    fn ft_list_sort(list: *mut *mut Node, cmp: ComparisonFunction);
}

	fn helper(data: &[*mut c_void], cmp: ComparisonFunction) {
		assert!(!data.is_empty(), "data must contain at least 1 element");

		let mut nodes: Vec<Node> =
			data.iter().map(|data| Node { data: *data, next: null_mut() }).collect();

		for i in 0..nodes.len() - 1 {
			nodes[i].next = &mut nodes[i + 1];
		}

		let mut head: *mut Node = nodes.as_mut_ptr();

		unsafe { ft_list_sort(&mut head, cmp) };
		assert!(!head.is_null());

		let mut count: usize = 1;
		let mut curr: *const Node = head;
		let mut next: *const Node = unsafe { (*curr).next };

		while !next.is_null() {
			assert!(unsafe { cmp((*curr).data, (*next).data) } <= 0);
			curr = next;
			next = unsafe { (*curr).next };
			count += 1;
		}
		assert_eq!(count, nodes.len());
	}

	fn list_of_3_u32() {
		helper(
			&[
				(&mut 1_319_907_935u32 as *mut u32).cast(),
				(&mut 135_613_662u32 as *mut u32).cast(),
				(&mut 2_807_841_294u32 as *mut u32).cast(),
			],
			cmp::<u32>,
		);
	}
	
fn main() {
	list_of_3_u32()
}
