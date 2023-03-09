import sys

# MJ也就是麻将，正好也是mahjong的缩写 
# id 表格值，自增id
# typeid 表格值，和表情类别对应
# displayorder 表格值，决定类别内表情的排序
# type 表格值，对于表情来说固定为smiley，表格内有其他值的项目
# code 表格值，表情对应的代码，一般在编辑正文里常见
# url 表格值，对于表情来说是去掉了前缀备注只有序号（和id不同）的文件名
# before_id 存储转化后的排序信息
class MJItem:
	id = 0
	typeid = 0
	displayorder = 0
	type = 'smiley'
	code = ''
	url = ''
	origin_file_path = ''
	before_id = 0

	def __init__(self, id, )

if __name__ == '__main__':
	py_ver = sys.version_info
	if py_ver.major < 3 and py_ver.minor < 8 and py_ver.micro < 6:
		print('please use python 3.8.6 or newer, '
			'which could be run on windows 7 or newer')
	else:
		print('program go on')
