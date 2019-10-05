python3 -m timeit --setup "
import daemon.daemon
import unittest.mock
fake_maxfd = 1048576
# fake_maxfd = 2048
unittest.mock.patch(
    'daemon.daemon.get_maximum_file_descriptors', return_value=fake_maxfd,
).start()
exclude_fds = set()
print('daemon.daemon.get_maximum_file_descriptors() returns {}'.format(
    daemon.daemon.get_maximum_file_descriptors()))
print('Timings for ‘daemon.daemon._get_candidate_file_descriptor_ranges({exclude_fds})’'.format(
    exclude_fds=exclude_fds))
" "
daemon.daemon._get_candidate_file_descriptor_ranges(exclude_fds)
"
