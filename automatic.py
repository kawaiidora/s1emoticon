import pathlib
import sys
import csv

DEBUG = True
source_file = 'cdb_common_smiley.csv'
destination_file = 'out.csv'


# 简易debug函数，输出到standard error，取决于顶部的DEBUG
def log(string):
    def debug_print_on_stderr(*args, **kwargs):
        print(*args, file=sys.stderr, **kwargs)

    if DEBUG:
        debug_print_on_stderr(string)


# MJ也就是麻将，正好也是mahjong的缩写
# csv_data 也就是从表格中读取的以及日后保存到表格的数据
# -分割线开始-
# 以下为表格数据说明
# id 表格值，自增id，为了避开python自带的id
# typeid 表格值，和表情类别对应
# displayorder 表格值，决定类别内表情的排序
# type 表格值，对于表情来说固定为smiley，表格内有其他值的项目
# code 表格值，表情对应的代码，一般在编辑正文里常见
# url 表格值，对于表情来说是去掉了前缀备注只有序号（和id不同）的文件名
# -分割线结束-
# origin_file_path 原始库中的文件名，也就是带有类别字母和描述的文件名
# before_id 存储转化后的排序信息，将文件名中的描述，
# 例如(before234)转化为234，表示在displayorder要在234号前面，
# 负数表示放在后面，例如(after030)转化为-30
class MJItem:
    csv_data = {}
    origin_file_path = ''
    before_id = 0

    def __init__(self, csv_data):
        self.csv_data = csv_data

    # 是否为麻将脸对象
    def is_mj_item(self):
        return self.csv_data['type'] == 'smiley'


main_directory = pathlib.Path().resolve()

categories = 'animal', 'bundam', 'carton', 'device', 'face', 'goose'

categories_to_typeid = {'animal': 1468, 'bundam': 1471, 'carton': 1467,
                        'device': 1469, 'face': 1465, 'goose': 1470}

if __name__ == '__main__':
    py_ver = sys.version_info
    if py_ver.major < 3 and py_ver.minor < 8 and py_ver.micro < 6:
        print('please use python 3.8.6 or newer, '
              'which could be run on windows 7 or newer')
    else:
        log('placeholder for program go on')
        Items = []
        # 1.读取数据表
        with open(main_directory.joinpath(source_file), 'r') as file:
            csvreader = csv.DictReader(file, delimiter=',')
            for row in csvreader:
                new_item = MJItem(row)
                Items.append(new_item)
        if DEBUG:
            for item in Items:
                log(f'{item.csv_data =}')
        # 2.从文件目录读取文件名和排序等信息，新文件添加新的项目
        # 3.根据文件名排序信息重新排序
        # 4.输出更新后数据表
        # 5.输出更新后文件，含增补包
