import java.util.ArrayList;
import java.util.List;

List<Body> bodyListCreate()
{
  return new ArrayList<Body>();
}

Body bodyListGetElement(List<Body> list, int index)
{
  return list.get(index);
}


int bodyListGetLength(List<Body> list)
{
  return list.size();
}

void bodyListAdd(List<Body> list, Body element)
{
  list.add(element);
}

void bodyListRemove(List<Body> list, Body element)
{
  list.remove(element);  
}
